"
I correspond to an accounting *journal entry*. I represent the details of one relevant part of a {{gtClass:VsTransaction}} e.g. *account* and *amount*. I am named following GnuCash terminology, which is perhaps a bit more colloquial.
# Numbering
In GnuCash, each split can have their own unique ID. We'll wait until the need arises to possibly implement this.

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
		'status'
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
	^ accountSource ifNil: [ VsBooks new ]
]

{ #category : 'accessing' }
VsSplit >> accountSource: anObject [
	accountSource := anObject
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
		putRemovingNil: anAgreement
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
	^ MAMoneyDescription new
		accessor: #amount;
		"display: [ :e | '$' , e asString ];"
		priority: 200;
		beRequired;
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
	
	| gtSearchSource |
	self flag: 'just to get started. Maybe a general DBSoup source?'.
	gtSearchSource := PeGtCollectedSearch new.
	gtSearchSource children 
		add: self softwareCatalog.

	^ MAToOneRelationDescription new
		accessor: #subject;
		priority: 300;
		gtSearchSource: gtSearchSource;
		classes: CwSoftware withAllSubclasses;
		yourself
]
