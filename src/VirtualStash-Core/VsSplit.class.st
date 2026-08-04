"
I correspond to an accounting journal entry. I represent one amount-bearing
part of a VsTransaction.

My transaction backlink records my sole owner. The owning transaction is
responsible for maintaining both ends through #splitAdd: and #splitRemove:.
My #transaction: setter prevents direct transfer from one non-nil owner to
another; remove me from my current transaction first.
"
Class {
	#name : 'VsSplit',
	#superclass : 'Object',
	#traits : 'VsTSplittable + MATPropertyOwner',
	#classTraits : 'VsTSplittable classTrait + MATPropertyOwner classTrait',
	#instVars : [
		'account',
		'accountSource',
		'amount',
		'memo',
		'number',
		'price',
		'reconcileDate',
		'status',
		'transaction'
	],
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'accessing' }
VsSplit >> account [
	^ self maLazyInstVarUsing: self accountDescription
]

{ #category : 'accessing' }
VsSplit >> account: anObject [
	account := anObject
]

{ #category : 'accessing' }
VsSplit >> accountSource [
	^ self transaction accountSource
]

{ #category : 'accessing' }
VsSplit >> accountSource: anObject [
	accountSource := anObject
]

{ #category : 'as yet unclassified' }
VsSplit >> addressBook [
	
	^ MpAddressBook uniqueInstance
]

{ #category : 'as yet unclassified' }
VsSplit >> agreement [

	^ self
		propertyAt: #agreement
		ifAbsent: [ nil ]
]

{ #category : 'as yet unclassified' }
VsSplit >> agreement: anAgreement [

	self
		propertyAt: #agreement
		putRemovingNil: anAgreement.
		
	anAgreement ifNil: [ ^ self ].
	
	self transaction ifNotNil: [ :t | t counterparty: anAgreement provider ].
	
	self ppValues: (self ppValues addAll: anAgreement ppValues)
]

{ #category : 'magritte-accessing' }
VsSplit >> agreementDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #agreement;
		priority: 300;
		gtSearchSource: [ :anObject | anObject agreementSource ];
		classes: VsAgreement withAllSubclasses;
		comment:
			'The agreement whose obligation or financial consequence this split represents.'
		yourself
]

{ #category : 'as yet unclassified' }
VsSplit >> agreementSource [

	^ VsAgreementFile uniqueInstance
]

{ #category : 'accessing' }
VsSplit >> amount [
	^ self maLazyInstVarUsing: self amountDescription
]

{ #category : 'accessing' }
VsSplit >> amount: anObject [
	amount := anObject
]

{ #category : 'magritte-accessing' }
VsSplit >> amountDescription [
	<magritteDescription>
	
	^ MAMoneyDescription vsNew
		accessor: #amount;
		comment: 'The signed monetary Quantity posted by this split.';
		beRequired;
		"display: [ :e | '$' , e asString ];"
		priority: 200;
		yourself
]

{ #category : 'private' }
VsSplit >> amountToString: aNumber [
	| intString decimalString |
	intString := '$', aNumber asInteger asStringWithCommas.
	decimalString := aNumber isInteger
		ifTrue: [ '00' ]
		ifFalse: [ (aNumber \\ 1 * 100) asInteger asString ].
	^ aNumber = 0
		ifTrue: [ '' ]
		ifFalse: [ intString , '.' , decimalString ]
]

{ #category : 'as yet unclassified' }
VsSplit >> beneficiary [

	^ self
		propertyAt: #beneficiary
		ifAbsent: [ nil ]
]

{ #category : 'as yet unclassified' }
VsSplit >> beneficiary: anMpEntity [

	^ self
		propertyAt: #beneficiary
		putRemovingNil: anMpEntity
]

{ #category : 'as yet unclassified' }
VsSplit >> beneficiaryDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #beneficiary;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook);
		priority: 300;
		classes: MpRelatableEntity allSubclasses;
		yourself
]

{ #category : 'accessing' }
VsSplit >> creditAmount [
	^ self isCredit 
		ifTrue: [ 
			self amount * -1;
				yourself ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
VsSplit >> debitAmount [
	^ self isDebit 
		ifTrue: [ self amount ]
		ifFalse: [ nil ]
]

{ #category : 'accessing' }
VsSplit >> isCredit [
	^ self amount negative
]

{ #category : 'accessing' }
VsSplit >> isDebit [
	^ self amount numericalValue strictlyPositive
]

{ #category : 'as yet unclassified' }
VsSplit >> journalColumnThreeDescription [
	^ self memoDescription
]

{ #category : 'accessing' }
VsSplit >> memo [
	^ self maLazyInstVarUsing: self memoDescription
]

{ #category : 'accessing' }
VsSplit >> memo: anObject [
	memo := anObject
]

{ #category : 'magritte-accessing' }
VsSplit >> memoDescription [
	<magritteDescription>

	^ MAMemoDescription new
		accessor: #memo;
		priority: 300;
		yourself
]

{ #category : 'accessing' }
VsSplit >> number [
	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : 'accessing' }
VsSplit >> number: aString [
	number := aString
]

{ #category : 'magritte-accessing' }
VsSplit >> numberDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		yourself
]

{ #category : 'as yet unclassified' }
VsSplit >> ppValues [

	^ self
		propertyAt: #ppValues
		ifAbsentPut: [ OrderedCollection new ]
]

{ #category : 'as yet unclassified' }
VsSplit >> ppValues: aCollection [

	^ self
		propertyAt: #ppValues
		putRemovingNil: aCollection
]

{ #category : 'accessing' }
VsSplit >> price [
	^ self maLazyInstVarUsing: self priceDescription
]

{ #category : 'accessing' }
VsSplit >> price: aNumber [
	price := aNumber
]

{ #category : 'magritte-accessing' }
VsSplit >> priceDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #price;
		default: 1;
		yourself
]

{ #category : 'printing' }
VsSplit >> printOn: aStream [
	amount ifNotNil: [ aStream print: amount ].
	account ifNotNil: [ 
			aStream
				space;
				print: account ].
	memo ifNotNil: [ 
			aStream
				space;
				nextPut: $(;
				nextPutAll: memo;
				nextPut: $) ]
]

{ #category : 'magritte-accessing' }
VsSplit >> projectList [

	^ PpProjectList uniqueInstance
]

{ #category : 'accessing' }
VsSplit >> reconcileDate [
	^ self maLazyInstVarUsing: self reconcileDateDescription
]

{ #category : 'accessing' }
VsSplit >> reconcileDate: aDate [
	reconcileDate := aDate
]

{ #category : 'magritte-accessing' }
VsSplit >> reconcileDateDescription [
	<magritteDescription>
	^ MADateDescription new
		accessor: #reconcileDate;
		yourself
]

{ #category : 'magritte-accessing' }
VsSplit >> softwareCatalog [

	^ CwSoftwareCatalog uniqueInstance
]

{ #category : 'commands' }
VsSplit >> splitAddCommand [
	"Answer a command prepared to take money from me into a new sibling
	split."

	self transaction ifNil: [
		self error: 'The split does not belong to a transaction' ].

	^ VsSplitAdd from: self
]

{ #category : 'gt-views' }
VsSplit >> splitAddGtViewFor: aView [
	<gtView>

	self transaction ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Add split';
		priority: 80;
		object: [ self splitAddCommand ];
		view: #maExecutingFormFor:
]

{ #category : 'accessing' }
VsSplit >> status [
	^ self maLazyInstVarUsing: self statusDescription
]

{ #category : 'accessing' }
VsSplit >> status: anObject [
	status := anObject
]

{ #category : 'as yet unclassified' }
VsSplit >> subject [

	self agreement ifNotNil: [ :a | ^ a subject ].

	^ self
		propertyAt: #subject
		ifAbsent: [ nil ]
]

{ #category : 'as yet unclassified' }
VsSplit >> subject: anObject [

	self
		propertyAt: #subject
		putRemovingNil: anObject
]

{ #category : 'magritte-accessing' }
VsSplit >> subjectDescription [
	<magritteDescription>
	
	| gtSearchSource classes |
	self flag: 'just to get started. Maybe a general DBSoup source?'.
	gtSearchSource := PeGtCollectedSearch new.
	gtSearchSource children 
		add: self softwareCatalog;
		add: self projectList.
		
	classes := OrderedCollection new
		addAll: PpValue withAllSubclasses;
		addAll: CwSoftware withAllSubclasses;
		yourself.

	^ MAToOneRelationDescription new
		accessor: #subject;
		priority: 300;
		gtSearchSource: [ gtSearchSource ];
		classes: classes;
		yourself
]

{ #category : 'accessing - ownership' }
VsSplit >> transaction [
	"Answer my owning transaction, or nil when I am not installed."

	^ transaction
]

{ #category : 'accessing - ownership' }
VsSplit >> transaction: aTransaction [
	"Set my owning transaction.

	Relationship-changing code should normally send #splitAdd: or
	#splitRemove: to a transaction. Prevent direct transfer between two
	non-nil owners because it would leave one side inconsistent."

	transaction ifNotNil: [ :currentOwner |
		(aTransaction isNotNil and: [
			currentOwner ~~ aTransaction ]) ifTrue: [
				self error:
					'Remove the split from its current transaction before reassigning it' ] ].

	transaction := aTransaction
]

{ #category : 'magritte-accessing' }
VsSplit >> transactionDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #transaction;
		classes: { VsTransaction };
		priority: 50;
		beReadOnly;
		comment: 'The transaction that owns this split.';
		yourself
]
