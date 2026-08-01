"
I add a fully described VsSplit to a transaction.

I contain a draft split and project its writable Magritte descriptions into my
flat command form. My optional splitSource identifies an existing split from
which my amount is taken. #from: uses the split backlink to prefill both the
transaction and source split.

I am a one-shot command invocation, not a reusable template. #execute installs
one split, records it as #result, and rejects a second execution. After
installation I detach my draft slot from the live result so a still-open
straight-memento form cannot continue mutating the installed split.

A separate split or transaction template should model reusable recipes.
"
Class {
	#name : 'VsSplitAdd',
	#superclass : 'Object',
	#instVars : [
		'split',
		'splitSource',
		'transaction',
		'result',
		'agreementIsSatisfied'
	],
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsSplitAdd class >> exampleAdd [
	<gtExample>

	| transaction account splitCountBefore addedSplit |
	transaction := VsBooks exampleHarryPotter generalJournal entries first.
	transaction splitsBacklinksMigrate.
	account := transaction splitsPrivate first account.
	splitCountBefore := transaction splitsPrivate size.

	addedSplit := (self to: transaction)
		account: account;
		amount: 1 dollars;
		execute.

	addedSplit class should be: VsSplit.
	addedSplit account should be: account.
	addedSplit amount should equal: 1 dollars.
	addedSplit accountSource should be: transaction accountSource.
	transaction splitsPrivate size should equal: splitCountBefore + 1.
	transaction splitsPrivate last should be: addedSplit.

	^ addedSplit
]

{ #category : 'examples' }
VsSplitAdd class >> exampleAllocateAgreement [
	<gtExample>

	| transaction sourceSplit sourceAmountBefore amount agreement addedSplit |
	transaction := VsBooks exampleHarryPotter generalJournal entries first.
	transaction splitsBacklinksMigrate.
	sourceSplit := transaction splitsPrivate
		detect: [ :each | each amount numericalValue isZero not ].
	sourceAmountBefore := sourceSplit amount.
	amount := sourceAmountBefore / 2.
	agreement := VsAgreement new.
	transaction agreementsUnallocatedAdd: agreement.

	addedSplit := (self to: transaction)
		account: sourceSplit account;
		amount: amount;
		splitSource: sourceSplit;
		agreement: agreement;
		agreementIsSatisfied: true;
		execute.

	addedSplit agreement should be: agreement.
	sourceSplit amount should equal: sourceAmountBefore - amount.
	(transaction agreementsUnallocated identityIncludes: agreement)
		should beFalse.
	(transaction agreements identityIncludes: agreement)
		should beTrue.

	^ addedSplit
]

{ #category : 'examples' }
VsSplitAdd class >> exampleFromSplit [
	<gtExample>

	| transaction sourceSplit command |
	transaction := VsBooks exampleHarryPotter generalJournal entries first.
	transaction splitsBacklinksMigrate.
	sourceSplit := transaction splitsPrivate
		detect: [ :each | each amount numericalValue isZero not ].

	command := self from: sourceSplit.

	command transaction should be: transaction.
	command splitSource should be: sourceSplit.

	^ command
]

{ #category : 'examples' }
VsSplitAdd class >> exampleTakeFromSplit [
	<gtExample>

	| transaction sourceSplit sourceAmountBefore amount splitCountBefore addedSplit |
	transaction := VsBooks exampleHarryPotter generalJournal entries first.
	transaction splitsBacklinksMigrate.
	sourceSplit := transaction splitsPrivate
		detect: [ :each | each amount numericalValue isZero not ].
	sourceAmountBefore := sourceSplit amount.
	amount := sourceAmountBefore / 2.
	splitCountBefore := transaction splitsPrivate size.

	addedSplit := (self to: transaction)
		account: sourceSplit account;
		amount: amount;
		splitSource: sourceSplit;
		execute.

	addedSplit amount should equal: amount.
	sourceSplit amount should equal: sourceAmountBefore - amount.
	transaction splitsPrivate size should equal: splitCountBefore + 1.

	^ addedSplit
]

{ #category : 'instance creation' }
VsSplitAdd class >> from: aSplit [
	"Answer a command prepared to take money from aSplit into a new sibling
	split."

	aSplit transaction ifNil: [
		self error: 'The source split does not belong to a transaction' ].

	^ (self to: aSplit transaction)
		splitSource: aSplit;
		yourself
]

{ #category : 'instance creation' }
VsSplitAdd class >> to: aTransaction [
	"Answer a command prepared to add a split to aTransaction."

	^ self new
		transaction: aTransaction;
		yourself
]

{ #category : 'accessing - split' }
VsSplitAdd >> account [
	"Answer the account assigned to my draft split."

	^ self split account
]

{ #category : 'accessing - split' }
VsSplitAdd >> account: anAccount [
	"Assign anAccount to my draft split."

	self split account: anAccount
]

{ #category : 'magritte - split' }
VsSplitAdd >> accountDescription [
	<magritteDescription>

	^ self split accountDescription copy
		accessor: #account;
		beRequired;
		comment: 'The account to which the new split will be posted.';
		yourself
]

{ #category : 'accessing - support' }
VsSplitAdd >> accountSource [
	"Answer the source used by split descriptions to select an account."

	^ self split accountSource
]

{ #category : 'accessing - split' }
VsSplitAdd >> agreement [
	"Answer the agreement assigned to my draft split."

	^ self split agreement
]

{ #category : 'accessing - split' }
VsSplitAdd >> agreement: anAgreement [
	"Assign anAgreement to my draft split."

	self split agreement: anAgreement
]

{ #category : 'magritte - command' }
VsSplitAdd >> agreementDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #agreement;
		options: self agreementOptions;
		priority: 300;
		comment:
			'An agreement to be linked to the draft split, chosen from the transactions unallocated agreements';
		yourself
]

{ #category : 'accessing - command' }
VsSplitAdd >> agreementIsSatisfied [
	"Answer whether assigning my split completes the selected agreement's
	allocation."

	^ agreementIsSatisfied ifNil: [ true ]
]

{ #category : 'accessing - command' }
VsSplitAdd >> agreementIsSatisfied: aBoolean [
	"Set whether assigning my split completes the selected agreement's
	allocation."

	agreementIsSatisfied := aBoolean
]

{ #category : 'magritte - command' }
VsSplitAdd >> agreementIsSatisfiedDescription [
	<magritteDescription>

	^ MABooleanDescription new
		accessor: #agreementIsSatisfied;
		label: 'Agreement fully allocated';
		default: true;
		priority: 310;
		comment:
			'When selected, execution removes the chosen agreement from the transaction''s unallocated agreements. Clear this when the split allocates only part of the agreement.';
		yourself
]

{ #category : 'accessing - support' }
VsSplitAdd >> agreementOptions [
	"Answer the agreements currently awaiting allocation on my transaction."

	self transaction ifNil: [ ^ #() ].
	^ self transaction agreementsUnallocated
]

{ #category : 'accessing - split' }
VsSplitAdd >> amount [
	"Answer the monetary Quantity assigned to my draft split."

	^ self split amount
]

{ #category : 'accessing - split' }
VsSplitAdd >> amount: aQuantity [
	"Assign a signed monetary Quantity to my draft split."

	self split amount: aQuantity
]

{ #category : 'magritte - split' }
VsSplitAdd >> amountDescription [
	<magritteDescription>

	| description |
	description := self split amountDescription copy
		accessor: #amount;
		kind: Quantity;
		beRequired;
		comment:
			'The signed monetary Quantity assigned to the new split and, when specified, taken from the source split.';
		yourself.

	description
		addCondition: [ :aQuantity |
			aQuantity isNil or: [
				aQuantity numericalValue isZero not ] ]
		labelled: 'The amount must not be zero'.

	description
		addCondition: [ :aQuantity |
			self amountSignMatchesSplitSource: aQuantity ]
		labelled: 'The amount must have the same sign as the source split amount'.

	description
		addCondition: [ :aQuantity |
			self amountIsAtMostSplitSource: aQuantity ]
		labelled: 'The amount exceeds the source split amount'.

	^ description
]

{ #category : 'validation' }
VsSplitAdd >> amountIsAtMostSplitSource: aQuantity [
	"Answer whether aQuantity can be taken from my source split.

	Nil is left to the required validator. Without a source split there is
	no upper bound to check."

	| sourceAmount |
	aQuantity ifNil: [ ^ true ].
	self splitSource ifNil: [ ^ true ].

	sourceAmount := self splitSource amount.
	sourceAmount ifNil: [ ^ false ].

	^ aQuantity abs <= sourceAmount abs
]

{ #category : 'validation' }
VsSplitAdd >> amountSignMatchesSplitSource: aQuantity [
	"Answer whether aQuantity has the same sign as my source split amount.

	Nil is left to the required validator. Without a source split there is
	no sign relationship to check."

	| sourceAmount |
	aQuantity ifNil: [ ^ true ].
	self splitSource ifNil: [ ^ true ].

	sourceAmount := self splitSource amount.
	sourceAmount ifNil: [ ^ false ].

	^ aQuantity negative = sourceAmount negative
]

{ #category : 'printing' }
VsSplitAdd >> displayStringOn: aStream [
	aStream nextPutAll: 'Add split'.

	self amount ifNotNil: [ :aQuantity |
		aStream
			nextPutAll: ' for ';
			display: aQuantity ]
]

{ #category : 'executing' }
VsSplitAdd >> execute [
	"Validate and execute this one-shot command.

	Answer the installed split. Reject a second execution."

	| installedSplit |
	self hasExecuted ifTrue: [
		self error: 'This split-add command has already been executed' ].

	self maValidate.

	self splitSource ifNotNil: [ :aSplit |
		aSplit amount: aSplit amount - self amount ].

	installedSplit := self split.
	self transaction splitAdd: installedSplit.

	self agreement ifNotNil: [ :anAgreement |
		self agreementIsSatisfied ifTrue: [
			self transaction agreementsUnallocatedRemove: anAgreement ] ].

	result := installedSplit.
	split := nil.

	^ result
]

{ #category : 'testing' }
VsSplitAdd >> hasExecuted [
	"Answer whether I have already installed my result."

	^ result isNotNil
]

{ #category : 'gt-views' }
VsSplitAdd >> maExecutingFormFor: aView [
	<gtView>

	| description |
	description := self magritteDescription.
	(description isContainer not or: [ description isEmpty ])
		ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Add split';
		priority: 25;
		stencil: [ self magritteFormExecuting asScrollableElement ]
]

{ #category : 'magritte' }
VsSplitAdd >> magritteDescription [
	"Answer my command descriptions combined with flat projections of every
	writable split description not replaced by a command-specific one."

	| result |
	result := super magritteDescription.
	result addAll: self splitDescriptions.
	^ result
]

{ #category : 'magritte' }
VsSplitAdd >> magritteFormExecuting [
	| builder |
	builder := self magritteDescription elementBuilderFor: self.
	builder addButtons: #(execute).
	^ builder element
]

{ #category : 'magritte' }
VsSplitAdd >> mementoClass [
	"Edits may flow directly into my private draft split.

	The draft is not part of the domain graph until #execute. Execution
	detaches my draft slot from the installed result so later form edits
	cannot mutate live bookkeeping state."

	^ MAStraightMemento
]

{ #category : 'printing' }
VsSplitAdd >> printOn: aStream [
	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing - result' }
VsSplitAdd >> result [
	"Answer the installed split after execution, or nil before execution."

	^ result
]

{ #category : 'accessing - split' }
VsSplitAdd >> split [
	"Answer the draft split that will be installed by #execute."

	^ split ifNil: [
		split := VsSplit new.
		self transaction ifNotNil: [ :aTransaction |
			split accountSource: aTransaction accountSource ].
		split ]
]

{ #category : 'magritte - split' }
VsSplitAdd >> splitDescriptionProjected: aDescription [
	"Answer a non-destructive projection of aDescription through #split."

	| label projected |
	label := aDescription label.
	projected := aDescription copy.
	projected label: label.
	projected chainAccessor: {
		#split.
		aDescription accessor }.
	^ projected
]

{ #category : 'magritte - split' }
VsSplitAdd >> splitDescriptionShouldProject: aDescription [
	"Answer whether aDescription represents a writable split field not
	replaced by a command-specific description."

	(aDescription accessor canWrite: self split) ifFalse: [ ^ false ].

	^ (#(account amount agreement)
		includes: aDescription accessor readSelector) not
]

{ #category : 'magritte - split' }
VsSplitAdd >> splitDescriptions [
	"Answer flat projections of the writable descriptions owned by VsSplit.

	This lets additions automatically gain newly described split fields
	without duplicating their definitions here."

	^ (self split magritteDescription
		select: [ :description |
			self splitDescriptionShouldProject: description ])
		collect: [ :description |
			self splitDescriptionProjected: description ]
]

{ #category : 'accessing - command' }
VsSplitAdd >> splitSource [
	"Answer the existing split from which my amount will be taken."

	^ splitSource
]

{ #category : 'accessing - command' }
VsSplitAdd >> splitSource: aSplit [
	"Set the existing split from which my amount will be taken."

	splitSource := aSplit
]

{ #category : 'magritte - command' }
VsSplitAdd >> splitSourceDescription [
	<magritteDescription>

	| description |
	description := MASingleOptionDescription new
		accessor: #splitSource;
		label: 'Take from';
		options: self splitSourceOptions;
		priority: 150;
		comment:
			'An optional existing split whose amount will be reduced by the amount assigned to the new split.';
		yourself.

	description
		addCondition: [ :aSplit |
			aSplit isNil or: [
				self transaction isNotNil and: [
					self transaction splitsPrivate identityIncludes: aSplit ] ] ]
		labelled:
			'The source split must belong to the target transaction'.

	^ description
]

{ #category : 'accessing - support' }
VsSplitAdd >> splitSourceOptions [
	"Answer the existing splits eligible to supply my amount."

	self transaction ifNil: [ ^ #() ].
	^ self transaction splitsPrivate
]

{ #category : 'accessing - command' }
VsSplitAdd >> transaction [
	"Answer the transaction that will receive my split."

	^ transaction
]

{ #category : 'accessing - command' }
VsSplitAdd >> transaction: aTransaction [
	"Set the transaction that will receive my split and configure the draft
	split to use its account source."

	self hasExecuted ifTrue: [
		self error: 'An executed command cannot be retargeted' ].

	transaction := aTransaction.
	aTransaction ifNotNil: [
		self split accountSource: aTransaction accountSource ]
]

{ #category : 'magritte - command' }
VsSplitAdd >> transactionDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #transaction;
		classes: { VsTransaction };
		priority: 100;
		beRequired;
		beReadOnly;
		yourself
]
