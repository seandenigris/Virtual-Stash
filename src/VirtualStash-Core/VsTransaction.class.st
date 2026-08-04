"
I represent a financial transaction, like a credit card purchase. I have at
least two VsSplits, possibly more.

I own my splits. New code should mutate that relationship only through
#splitAdd: and #splitRemove:. #splitsPrivate exposes the actual contained
collection for queries and framework integration; its name is intended to
warn callers not to mutate it directly. #splits remains temporarily as a
compatibility alias while existing senders are migrated.

My agreements include agreements allocated to amount-bearing splits and
agreements known to participate whose amounts are not yet fully allocated.
"
Class {
	#name : 'VsTransaction',
	#superclass : 'Object',
	#traits : 'DbTDomainObject + VsTTransactable',
	#classTraits : 'DbTDomainObject classTrait + VsTTransactable classTrait',
	#instVars : [
		'accountSource',
		'addressBook',
		'date',
		'memo',
		'number',
		'receipt',
		'splits',
		'voidReason',
		'counterparty',
		'processor'
	],
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsTransaction class >> example [
	^ self new
		counterparty: MpOrganization examplePhillyZoo;
		yourself
]

{ #category : 'examples' }
VsTransaction class >> exampleSplitOwnership [
	<gtExample>

	| transaction |
	transaction := VsBooks exampleHarryPotter generalJournal entries first.
	transaction splitsBacklinksMigrate.

	(transaction splitsPrivate allSatisfy: [ :split |
		split transaction == transaction ]) should beTrue.

	^ transaction
]

{ #category : 'testing' }
VsTransaction class >> isAbstract [
	^ false
]

{ #category : 'as yet unclassified' }
VsTransaction class >> memo: aString append: anotherString [

	^ String streamContents: [ :s |
		aString ifNotEmpty: [ :m | 
			s nextPutAll: m; nextPutAll: '; ' ].
		s nextPutAll: anotherString ].
]

{ #category : 'accessing' }
VsTransaction >> accountSource [
	"One reason we have to store this is that new snippets need to know it, and we pass it to them"
	^ accountSource
]

{ #category : 'accessing' }
VsTransaction >> accountSource: anObject [
	accountSource := anObject
]

{ #category : 'accessing' }
VsTransaction >> accounts [
	^ self splitsCollectUniqueNotNil: #account
]

{ #category : 'magritte-accessing' }
VsTransaction >> accountsDescription [
	"Used by e.g. ==#printRegister:== to select relevant transactions"
	^ MAMultipleOptionDescription new
		accessor: #accounts;
		beReadonly;
		comment: 'a.k.a. Category, which seems more aimed at the casual user, rather than accounting industry standard';
		yourself
]

{ #category : 'accessing' }
VsTransaction >> addressBook [

	^ addressBook ifNil: [ MpAddressBook uniqueInstance ]
]

{ #category : 'accessing' }
VsTransaction >> addressBook: anObject [

	addressBook := anObject
]

{ #category : 'as yet unclassified' }
VsTransaction >> agreement: aVsAgreement [ 
	
	self splits do: [ :aSplit |
		aSplit agreement: aVsAgreement ].
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreements [
	"Answer every agreement affecting me."

	^ IdentitySet new
		addAll: self agreementsAllocated;
		addAll: self agreementsUnallocated;
		yourself
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreementsAllocated [
	"Answer the agreements linked to at least one of my splits."

	^ self splitsPrivate
		inject: IdentitySet new
		into: [ :result :split |
			split agreement ifNotNil: [ :anAgreement |
				result add: anAgreement ].
			result ]
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreementsUnallocated [
	"Answer agreements affecting me whose full amounts have not yet been allocated to splits.

	An agreement may also appear in #agreementsAllocated while it remains only partially allocated."

	^ self
		propertyAt: #agreementsUnallocated
		ifAbsentPut: [ IdentitySet new ]
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreementsUnallocated: aCollection [
	"Replace the agreements awaiting allocation."
	
	| sanitizedCollection |
	sanitizedCollection := aCollection ifNotNil: [ :agreements |
		agreements asIdentitySet ].

	^ self
		propertyAt: #agreementsUnallocated
		putRemovingNil: sanitizedCollection
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreementsUnallocatedAdd: anAgreement [
	"Record that anAgreement affecting me, but which is not yet fully allocated to splits."

	^ self agreementsUnallocated add: anAgreement
]

{ #category : 'magritte-accessing' }
VsTransaction >> agreementsUnallocatedDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #agreementsUnallocated;
		label: 'Unallocated agreements';
		default: IdentitySet new;
		classes: VsAgreement withAllSubclasses;
		gtSearchSource: [ VsAgreementFile uniqueInstance ];
		priority: 425;
		comment:
			'Agreements affecting this transaction whose full amounts have not yet been allocated to splits.';
		yourself
]

{ #category : 'accessing - agreements' }
VsTransaction >> agreementsUnallocatedRemove: anAgreement [
	"Record that anAgreement no longer awaits allocation."

	^ self agreementsUnallocated remove: anAgreement
]

{ #category : 'accessing' }
VsTransaction >> amount [

  | credits debits creditTotal debitTotal |
  credits := self splitsPrivate select: #isCredit.
  debits := self splitsPrivate select: #isDebit.
  creditTotal := credits inject: 0 dollars into: [ :sum :e | sum + e amount ].
  debitTotal := debits inject: 0 dollars into: [ :sum :e | sum + e amount ].
  ^ { creditTotal . debitTotal } detectMax: #abs
]

{ #category : 'magritte-accessing' }
VsTransaction >> amountDescription [
	<magritteDescription>
	
	^ MAMoneyDescription vsNew
		accessor: #amount;
		priority: 500;
		beReadOnly;
		yourself
]

{ #category : 'accessing' }
VsTransaction >> applyRule: aVsCounterpartyRule [
	aVsCounterpartyRule
		transaction: self;
		apply.
]

{ #category : 'as yet unclassified' }
VsTransaction >> beneficiaries [

	^ self splitsCollectUniqueNotNil: #beneficiary
]

{ #category : 'as yet unclassified' }
VsTransaction >> beneficiary: anObject [

	self splits do: [ :s | s beneficiary: anObject ]
]

{ #category : 'as yet unclassified' }
VsTransaction >> books [

	^ self accountSource
]

{ #category : 'as yet unclassified' }
VsTransaction >> collectFrom: aCollection uniqueNotNil: aBlock [

  ^ aCollection asSet collect: aBlock thenReject: #isNil
]

{ #category : 'GnuCash' }
VsTransaction >> commodity [
	^ self maLazyPropertyUsing: self commodityDescription
]

{ #category : 'GnuCash' }
VsTransaction >> commodity: aString [
	self
		propertyAt: self commodityDescription accessor readSelector
		put: aString
]

{ #category : 'GnuCash' }
VsTransaction >> commodityDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #commodity;
		default: 'CURRENCY::USD';
		"propertyAt: #csvFieldName put: 'Commodity/Currency';"
		yourself
]

{ #category : 'accessing' }
VsTransaction >> counterparty [
	^ counterparty
]

{ #category : 'accessing' }
VsTransaction >> counterparty: anObject [
	counterparty := anObject
]

{ #category : 'magritte-accessing' }
VsTransaction >> counterpartyDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #counterparty;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook);
		priority: 300;
		classes: MpRelatableEntity allSubclasses;
		comment: 'Often called the ==payee== in accounting software, but this is misleading. The payee of a refund is the user, but is that really what we want to know? No! GnuCash gives up altogether and puts a free-form ==description== field where the ==payee== usually goes. Counterparty is the most precise term, meaning the entity on the other side of the transaction.';
		yourself
]

{ #category : 'accessing' }
VsTransaction >> date [
	^ date
]

{ #category : 'accessing' }
VsTransaction >> date: anObject [
	date := anObject
]

{ #category : 'GnuCash' }
VsTransaction >> gnuCashID [
	^ self maLazyPropertyUsing: self gnuCashIDDescription
]

{ #category : 'GnuCash' }
VsTransaction >> gnuCashID: aString [
	self
		propertyAt: self gnuCashIDDescription accessor readSelector
		put: aString
]

{ #category : 'GnuCash' }
VsTransaction >> gnuCashIDDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #gnuCashID;
		yourself
]

{ #category : 'accessing' }
VsTransaction >> gtViewJournalOn: aView [
	<gtView>
	| result |
	result := aView columnedList
		title: 'Splits' translated;
		priority: 5;
		items: [ self journalLines ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result
]

{ #category : 'accessing' }
VsTransaction >> gtViewRulesOn: aView [

	<gtView>
	^ aView list
		title: 'Rules';
		priority: 75;
		items: [ VsImportRule allFor: self ];
		actionUpdateButton;
		yourself
]

{ #category : 'accessing' }
VsTransaction >> importedName [
	^ self maLazyPropertyUsing: (self importedNameDescription)
]

{ #category : 'accessing' }
VsTransaction >> importedName: aString [
	self propertyAt: #importedName put: aString
]

{ #category : 'magritte-accessing' }
VsTransaction >> importedNameDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		accessor: #importedName;
		yourself
]

{ #category : 'accessing' }
VsTransaction >> isValid [
	^ self date isNotNil
]

{ #category : 'GnuCash' }
VsTransaction >> journalColumnThreeDescription [
	^ self counterpartyDescription
]

{ #category : 'accessing' }
VsTransaction >> journalLines [

  ^ OrderedCollection new
      add: self;
      addAll: self splitsPrivate;
      collect: [ :e |
          VsJournalLine new
            model: e;
            yourself
        ]
]

{ #category : 'accessing' }
VsTransaction >> memo [
	^ self maLazyInstVarUsing: self memoDescription
]

{ #category : 'accessing' }
VsTransaction >> memo: anObject [
	memo := anObject
]

{ #category : 'accessing' }
VsTransaction >> memoAppend: aString [
	memo := self class memo: memo append: aString
]

{ #category : 'magritte-accessing' }
VsTransaction >> memoDescription [
	"The term 'memo' seems to be the industry standard. a.k.a. 'notes' (also a good name) and 'description', which we ruled out to avoid confusion because GnuCash uses it as a poor-man's 'payee' field"
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #memo;
		priority: 300;
		default: '';
		yourself
]

{ #category : 'testing' }
VsTransaction >> needsAgreementAllocation [
	"Answer whether at least one participating agreement awaits full
	allocation to splits."

	^ self agreementsUnallocated isNotEmpty
]

{ #category : 'magritte-accessing' }
VsTransaction >> needsAgreementAllocationDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #needsAgreementAllocation;
		label: 'Needs agreement allocation';
		priority: 426;
		beReadOnly;
		comment:
			'Whether one or more participating agreements still need to be fully allocated to splits.';
		yourself
]

{ #category : 'accessing' }
VsTransaction >> number [
	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : 'accessing' }
VsTransaction >> number: aNumber [
	number := aNumber
]

{ #category : 'as yet unclassified' }
VsTransaction >> ppValues [

  ^ self splitsPrivate flatCollect: #ppValues
]

{ #category : 'as yet unclassified' }
VsTransaction >> ppValues: aCollection [

	^ self splits do: [ :s | s ppValues: aCollection ]
]

{ #category : 'printing' }
VsTransaction >> printOn: aStream [
	{ self dateDescription. self amountDescription. self counterpartyDescription. self memoDescription } 
		do: [ :d | aStream maPrint: d for:  self ]
		separatedBy: [ aStream space ]
]

{ #category : 'accessing' }
VsTransaction >> processor [
	^ processor
]

{ #category : 'accessing' }
VsTransaction >> processor: anObject [
	processor := anObject
]

{ #category : 'magritte-accessing' }
VsTransaction >> processorDescription [
	
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #processor;
			options: self addressBook organizations asEntityCollection;
			priority: 550;
			yourself
]

{ #category : 'accessing' }
VsTransaction >> receipt [
	^ receipt
]

{ #category : 'accessing' }
VsTransaction >> receipt: anObject [
	receipt := anObject
]

{ #category : 'magritte-accessing' }
VsTransaction >> receiptDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #receipt;
			classes: { VsReceipt };
			priority: 700;
			yourself
]

{ #category : 'accessing' }
VsTransaction >> receiptImportEmail [

  | emls newReceipt |
  emls := RlEmail allFromMailClientSelectionImport.
  self assert: emls size = 1.
  newReceipt :=  VsReceipt new
          resource: emls first;
          yourself.
  self receipt: newReceipt.
  ^ newReceipt
]

{ #category : 'accessing' }
VsTransaction >> registerString [
	^ (self maToString: self dateDescription), '	', (self maToString: self counterpartyDescription), '	', (self maToString: self accountsDescription), '	', (self maToString: self amountDescription)
]

{ #category : 'adding/removing - splits' }
VsTransaction >> splitAdd: aSplit [
	"Add aSplit as my child and establish the backlink.

	A split already owned by another transaction must first be removed from that transaction."

	aSplit ifNil: [ self error: 'A split is required' ].

	aSplit transaction ifNotNil: [ :owner |
		owner == self ifFalse: [
			self error: 'The split already belongs to another transaction' ] ].

	(self splitsPrivate identityIncludes: aSplit) ifTrue: [ ^ aSplit ].

	aSplit
		transaction: self;
		accountSource: self accountSource.

	^ self splitsPrivate add: aSplit
]

{ #category : 'commands' }
VsTransaction >> splitAddCommand [
	"Answer a command prepared to add a split to me."

	^ VsSplitAdd to: self
]

{ #category : 'adding/removing - splits' }
VsTransaction >> splitRemove: aSplit [
	"Remove aSplit from me and clear its backlink.

	Answer aSplit"

	| removed |
	removed := self splitsPrivate remove: aSplit.

	aSplit transaction == self ifTrue: [
		aSplit transaction: nil ].

	^ removed
]

{ #category : 'compatibility - splits' }
VsTransaction >> splits [
	"Compatibility alias.

	New code should query #splitsPrivate and mutate only through #splitAdd:
	and #splitRemove:. This method remains temporarily while existing
	senders are migrated."
	
	self
		deprecated: 'Use #splitsPrivate instead'
		transformWith: '`@receiver splits' -> '`@receiver splitsPrivate'.

	^ self splitsPrivate
]

{ #category : 'compatibility - splits' }
VsTransaction >> splits: aCollection [
	"Compatibility alias for #splitsPrivate:."
	
	self
		deprecated: 'Use #splitsPrivate: instead'
		transformWith: '`@receiver splits:' -> '`@receiver splitsPrivate:'.

	^ self splitsPrivate: aCollection
]

{ #category : 'migration' }
VsTransaction >> splitsBacklinksMigrate [
	"Populate backlinks for my existing splits.

	This migration is intentionally explicit and is not run during load.
	Signal an error rather than silently stealing a split that already
	belongs to another transaction."

	self splitsPrivate do: [ :split |
		split transaction
			ifNil: [ split transaction: self ]
			ifNotNil: [ :owner |
				owner == self ifFalse: [
					self error:
						'A split is already linked to another transaction' ] ].
		split accountSource: self accountSource ].

	^ self
]

{ #category : 'as yet unclassified' }
VsTransaction >> splitsCollectUniqueNotNil: aBlock [

  ^ self splitsPrivate asSet collect: aBlock thenReject: #isNil
]

{ #category : 'magritte-accessing' }
VsTransaction >> splitsDescription [
	<magritteDescription>
	"Describe my owned splits.

	The accessor is deliberately #splitsPrivate. Relationship-changing
	code should still prefer #splitAdd: and #splitRemove:."

	^ MAToManyRelationDescription new
		accessor: #splitsPrivate;
		default: OrderedCollection new;
		classes: { VsSplit };
		initializer: [ :newSplit |
			newSplit
				accountSource: self accountSource;
				amount: self uncategorizedAmount ];
		priority: 400;
		yourself
]

{ #category : 'accessing - private' }
VsTransaction >> splitsPrivate [
	"Answer my actual mutable split collection.

	Do not add to or remove from this collection directly. Use #splitAdd:
	and #splitRemove: so the split-to-transaction backlink remains valid."

	^ splits ifNil: [ splits := OrderedCollection new ]
]

{ #category : 'accessing - private' }
VsTransaction >> splitsPrivate: aCollection [
	"Replace my split collection while preserving ownership invariants.

	This setter exists for framework and materialization integration.
	Ordinary mutation should use #splitAdd: and #splitRemove:."

	| newSplits oldSplits |
		
	newSplits := aCollection
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :collection | collection asOrderedCollection ].

	newSplits asIdentitySet size = newSplits size ifFalse: [
		self error: 'A transaction cannot contain the same split twice' ].

	newSplits do: [ :split |
		split transaction ifNotNil: [ :owner |
			owner == self ifFalse: [
				self error:
					'A replacement split belongs to another transaction' ] ] ].

	oldSplits := splits ifNil: [ #() ].
	oldSplits do: [ :split |
		(newSplits identityIncludes: split) ifFalse: [
			split transaction == self ifTrue: [
				split transaction: nil ] ] ].

	splits := OrderedCollection new.
	newSplits do: [ :split | self splitAdd: split ].

	^ splits
]

{ #category : 'as yet unclassified' }
VsTransaction >> subject: anObject [

	self splits do: [ :s | s subject: anObject ]
]

{ #category : 'as yet unclassified' }
VsTransaction >> subjects [

	| unallocatedSubjects splitSubjects |
	unallocatedSubjects := self collectFrom: self agreementsUnallocated uniqueNotNil: #subject.
	splitSubjects := self collectFrom: self splitsPrivate uniqueNotNil: #subject.
	
	^ unallocatedSubjects, splitSubjects
]

{ #category : 'accessing' }
VsTransaction >> uncategorizedAmount [

	| categorizedAmount |
	categorizedAmount := self splits inject: 0 into: [ :sum :e | sum + e amount ].
	^ self amount - categorizedAmount
]

{ #category : 'GnuCash' }
VsTransaction >> voidReason [
	^ self maLazyInstVarUsing: self voidReasonDescription
]

{ #category : 'GnuCash' }
VsTransaction >> voidReason: aString [
	voidReason := aString
]

{ #category : 'GnuCash' }
VsTransaction >> voidReasonDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (MAPropertyAccessor key: #voidReason);
		yourself
]
