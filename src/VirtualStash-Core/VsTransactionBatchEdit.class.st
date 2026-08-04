"
I apply one set of edits to every transaction in my journal.

My transaction-level edits are counterparty and agreementsAdded. Agreements
added by the command begin as unallocated.

My remaining semantic fields are split-level edits. accountOld identifies
exactly one split in each transaction. accountNew, agreement, beneficiary,
projects, and subject are applied only to that split. When agreementSatisfied
is true, assigning agreement also removes it from the transaction's
unallocated agreements.

I validate the entire batch before changing any transaction, so an ambiguous
or missing accountOld match cannot leave a partially updated journal.
"
Class {
	#name : 'VsTransactionBatchEdit',
	#superclass : 'Object',
	#instVars : [
		'accountNew',
		'counterparty',
		'accountOld',
		'projects',
		'journal',
		'agreement',
		'beneficiary',
		'subject',
		'agreementsAdded',
		'agreementIsSatisfied'
	],
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsTransactionBatchEdit class >> exampleAddAgreements [
	<gtExample>

	| journal agreement command |
	journal := VsBooks exampleHarryPotter generalJournal.
	agreement := VsAgreement new.

	command := self new
		journal: journal;
		agreementsAdded: { agreement };
		yourself.
	command execute.

	(journal entries allSatisfy: [ :transaction |
		transaction agreementsUnallocated identityIncludes: agreement ])
			should beTrue.

	^ command
]

{ #category : 'examples' }
VsTransactionBatchEdit class >> exampleAllocateAgreement [
	<gtExample>

	| journal agreement command |
	journal := VsBooks exampleHarryPotter generalJournal.
	journal splitsBacklinksMigrate.
	agreement := VsAgreement new.

	command := journal batchEditCommand
		agreementsAdded: { agreement };
		agreement: agreement;
		agreementIsSatisfied: true;
		yourself.
	command execute.

	journal entries do: [ :transaction |
		| selectedSplit |
		selectedSplit := transaction splitsPrivate
			detect: [ :split |
				split account = command accountOld ].
		selectedSplit agreement should be: agreement.
		(transaction agreementsUnallocated identityIncludes: agreement)
			should beFalse ].

	^ command
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountNew [

  ^ accountNew
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountNew: anObject [

  accountNew := anObject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountNewDescription [
	<magritteDescription>

	^ self splitsFirst accountDescription copy
		label: 'New account';
		accessor: #accountNew;
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountOld [

  ^ accountOld
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountOld: anObject [

  accountOld := anObject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountOldDescription [
	<magritteDescription>

	| description |
	description := self splitsFirst accountDescription copy
		accessor: #accountOld;
		label: 'Old account';
		yourself.

	description
		addCondition: [ :anAccount |
			self splitChangesRequested not or: [
				anAccount isNotNil ] ]
		labelled:
			'Old account is required when changing split fields'.

	description
		addCondition: [ :anAccount |
			self accountOldMatchesEveryTransactionWhenNeeded: anAccount ]
		labelled:
			'Old account must identify exactly one split in every transaction'.

	^ description
]

{ #category : 'validation' }
VsTransactionBatchEdit >> accountOldMatchesEveryTransactionWhenNeeded: anAccount [
	"Answer whether anAccount identifies exactly one split in every
	transaction when split-level changes are requested."

	self splitChangesRequested ifFalse: [ ^ true ].
	anAccount ifNil: [ ^ false ].
	self journal ifNil: [ ^ false ].

	^ self journal entries allSatisfy: [ :transaction |
		(transaction splitsPrivate count: [ :split |
			split account = anAccount ]) = 1 ]
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> accountSource [

  ^ self books
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreement [

  ^ agreement
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreement: anObject [

  agreement := anObject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreementDescription [
	<magritteDescription>

	^ self splitsFirst agreementDescription copy
		accessor: #agreement;
		label: 'Allocate agreement';
		gtSearchSource: (MessageSend
			receiver: self splitsFirst
			selector: #agreementSource);
		comment:
			'Assign this agreement to the split selected by Old account.';
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreementIsSatisfied [
	"Answer whether assigning agreement fully allocates it."

	^ agreementIsSatisfied ifNil: [ true ]
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreementIsSatisfied: aBoolean [
	"Set whether assigning agreement fully allocates it."

	agreementIsSatisfied := aBoolean
]

{ #category : 'magritte-accessing' }
VsTransactionBatchEdit >> agreementIsSatisfiedDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #agreementIsSatisfied;
		label: 'Agreement fully allocated';
		default: true;
		priority: 310;
		comment:
			'When selected, remove the allocated agreement from each transaction''s unallocated agreements.';
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreementsAdded [
	"Answer agreements to add to every transaction as unallocated."

	^ self maLazyInstVarUsing: self agreementsAddedDescription
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> agreementsAdded: aCollection [
	"Set agreements to add to every transaction as unallocated."

	agreementsAdded := aCollection
		ifNotNil: [ :agreements | agreements asIdentitySet ]
]

{ #category : 'magritte-accessing' }
VsTransactionBatchEdit >> agreementsAddedDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #agreementsAdded;
		label: 'Add agreements';
		default: IdentitySet new;
		classes: VsAgreement withAllSubclasses;
		gtSearchSource: [ VsAgreementFile uniqueInstance ];
		priority: 305;
		comment:
			'Agreements to add to every transaction. They begin as unallocated.';
		yourself
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> beneficiary [

  ^ beneficiary
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> beneficiary: anObject [

  beneficiary := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> beneficiaryDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #beneficiary;
		gtSearchSource: [ MpAddressBook uniqueInstance ];
		priority: 300;
		classes: MpRelatableEntity allSubclasses;
		yourself
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> books [
	
	^ self journal entries first accountSource
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> chartOfAccounts [
	
	^ self books chartOfAccounts
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> counterparty [

  ^ counterparty
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> counterparty: anObject [

  counterparty := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> counterpartyDescription [
	<magritteDescription>
	
	^ VsTransaction magritteTemplate counterpartyDescription
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> displayStringOn: aStream [

	aStream
		nextPutAll: '[';
		print: self journal entries size;
		nextPutAll: ' transactions]'
]

{ #category : 'executing' }
VsTransactionBatchEdit >> execute [
	"Validate the complete command before applying it to any transaction."

	self maValidate.
	self journal entries do: [ :transaction |
		self updateTransaction: transaction ]
]

{ #category : 'views' }
VsTransactionBatchEdit >> gtJournalFor: aView [
  <gtView>
  
  ^ aView forward
      title: 'Transactions';
      priority: 1;
      object: [ self journal ];
      view: #entriesGtViewOn:
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> journal [

  ^ journal
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> journal: anObject [

  journal := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> maExecutingFormFor: aView [
	<gtView>

	| description |
	
	"Cache the description because this can be expensive and we want the view to be fast not to break the debugging workflow"
	description := self magritteDescription.
	
	(description isContainer not or: [ description isEmpty ]) ifTrue: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Magritte';
		priority: 25;
		stencil: [ self magritteFormExecuting asScrollableElement ]
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> magritteFormExecuting [

	| builder |
	builder := self magritteDescription elementBuilderFor: self.
	builder addButtons: #(execute).
	^ builder element
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> mementoClass [

	^ MAStraightMemento
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projectList [

	^ PpProjectList uniqueInstance
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projects [

  ^ self maLazyInstVarUsing: self projectsDescription
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projects: anObject [

  projects := anObject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> projectsDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #projects;
		gtSearchSource: [ self projectList ];
		default: OrderedCollection new;
		classes: PpValue withAllSubclasses;
		yourself.
]

{ #category : 'testing' }
VsTransactionBatchEdit >> splitChangesRequested [
	"Answer whether I contain any edit that must target one split."

	self accountNew ifNotNil: [ ^ true ].
	self agreement ifNotNil: [ ^ true ].
	self beneficiary ifNotNil: [ ^ true ].
	self projects ifNotEmpty: [ ^ true ].
	^ self subject isNotNil
]

{ #category : 'accessing - support' }
VsTransactionBatchEdit >> splitMatchingAccountOldIn: aTransaction [
	"Answer the sole split selected by accountOld.

	Validation should guarantee that the match exists and is unambiguous."

	^ aTransaction splitsPrivate
		detect: [ :split | split account = self accountOld ]
		ifNone: [ nil ]
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> splitsFirst [
	^ self journal entries first splitsPrivate first
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> subject [

  ^ subject
]

{ #category : 'accessing' }
VsTransactionBatchEdit >> subject: anObject [

  subject := anObject
]

{ #category : 'as yet unclassified' }
VsTransactionBatchEdit >> subjectDescription [
	<magritteDescription>
	
	^ self splitsFirst subjectDescription
]

{ #category : 'executing' }
VsTransactionBatchEdit >> updateTransaction: aTransaction [
	"Apply my transaction-level edits and then my selected split-level edits."

	| split |
	self agreementsAdded do: [ :anAgreement |
		aTransaction agreementsUnallocatedAdd: anAgreement ].

	self counterparty ifNotNil: [ :aCounterparty |
		aTransaction counterparty: aCounterparty ].

	self splitChangesRequested ifFalse: [ ^ aTransaction ].

	split := self splitMatchingAccountOldIn: aTransaction.
	
	split ifNil: [ ^ aTransaction ].

	self accountNew ifNotNil: [ :anAccount |
		split account: anAccount ].

	self agreement ifNotNil: [ :anAgreement |
		split agreement: anAgreement.
		aTransaction counterparty: anAgreement provider.
		self agreementIsSatisfied ifTrue: [
			aTransaction agreementsUnallocatedRemove: anAgreement ] ].

	self beneficiary ifNotNil: [ :anEntity |
		split beneficiary: anEntity ].

	self projects ifNotEmpty: [
		split ppValues: self projects ].

	self subject ifNotNil: [ :anObject |
		split subject: anObject ].

	^ aTransaction
]
