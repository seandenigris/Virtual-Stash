"
I correspond to an accounting *journal entry*. I represent the details of one relevant part of a {{gtClass:VsTransaction}} e.g. *account* and *amount*. I am named following GnuCash terminology, which is perhaps a bit more colloquial.
# Numbering
In GnuCash, each split can have their own unique ID. We'll wait until the need arises to possibly implement this.

"
Class {
	#name : #VsSplit,
	#superclass : #Object,
	#traits : 'VsTSplittable',
	#classTraits : 'VsTSplittable classTrait',
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
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsSplit >> account [
	^ self maLazyInstVarUsing: self accountDescription
]

{ #category : #accessing }
VsSplit >> account: anObject [
	account := anObject
]

{ #category : #accessing }
VsSplit >> accountSource [
	^ accountSource ifNil: [ VsBooks new ]
]

{ #category : #accessing }
VsSplit >> accountSource: anObject [
	accountSource := anObject
]

{ #category : #accessing }
VsSplit >> amount [
	^ self maLazyInstVarUsing: self amountDescription
]

{ #category : #accessing }
VsSplit >> amount: anObject [
	amount := anObject
]

{ #category : #'magritte-accessing' }
VsSplit >> amountDescription [
	<magritteDescription>
	^ MAMoneyDescription new
			accessor: #amount;
			label: 'Amount';
			"display: [ :e | '$' , e asString ];"
			priority: 200;
			beRequired;
			yourself
]

{ #category : #private }
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

{ #category : #accessing }
VsSplit >> creditAmount [
	^ self isCredit 
		ifTrue: [ 
			self amount * -1;
				yourself ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
VsSplit >> debitAmount [
	^ self isDebit 
		ifTrue: [ self amount ]
		ifFalse: [ nil ]
]

{ #category : #'magritte-accessing' }
VsSplit >> gnuCashAmountDescription: aDescription [
	<magritteDescription: #amountDescription>
	^ aDescription
		csvFieldName: 'Amount Num.';
		csvReader: [ :str | str vsAsUSD ];
		yourself
]

{ #category : #'magritte-accessing' }
VsSplit >> gnuCashMemoDescription: aDescription [
	<magritteDescription: #memoDescription>
	^ aDescription
		csvFieldName: 'Memo';
		yourself
]

{ #category : #'magritte-accessing' }
VsSplit >> gnuCashNumberDescription: aDescription [
	<magritteDescription: #numberDescription>
	^ aDescription
		csvFieldName: 'Number/Action';
		yourself
]

{ #category : #'magritte-accessing' }
VsSplit >> gnuCashPriceDescription: aDescription [
	<magritteDescription: #priceDescription>
	^ aDescription
		csvFieldName: 'Rate/Price';
		yourself
]

{ #category : #'magritte-accessing' }
VsSplit >> gnuCashReconcileDateDescription: aDescription [
	<magritteDescription: #reconcileDateDescription>
	^ aDescription
		csvFieldName: 'Reconcile Date';
		yourself
]

{ #category : #accessing }
VsSplit >> isCredit [
	^ self amount amount < 0
]

{ #category : #accessing }
VsSplit >> isDebit [
	^ self amount amount > 0
]

{ #category : #'as yet unclassified' }
VsSplit >> journalColumnThreeDescription [
	^ self memoDescription
]

{ #category : #accessing }
VsSplit >> memo [
	^ self maLazyInstVarUsing: self memoDescription
]

{ #category : #accessing }
VsSplit >> memo: anObject [
	memo := anObject
]

{ #category : #'magritte-accessing' }
VsSplit >> memoDescription [
	<magritteDescription>

	^ MAMemoDescription new
			accessor: #memo;
			label: 'Memo';
			priority: 300;
			yourself
]

{ #category : #accessing }
VsSplit >> number [
	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : #accessing }
VsSplit >> number: aString [
	number := aString
]

{ #category : #'magritte-accessing' }
VsSplit >> numberDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		yourself
]

{ #category : #accessing }
VsSplit >> price [
	^ self maLazyInstVarUsing: self priceDescription
]

{ #category : #accessing }
VsSplit >> price: aNumber [
	price := aNumber
]

{ #category : #'magritte-accessing' }
VsSplit >> priceDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #price;
		default: 1;
		yourself
]

{ #category : #printing }
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

{ #category : #accessing }
VsSplit >> reconcileDate [
	^ self maLazyInstVarUsing: self reconcileDateDescription
]

{ #category : #accessing }
VsSplit >> reconcileDate: aDate [
	reconcileDate := aDate
]

{ #category : #'magritte-accessing' }
VsSplit >> reconcileDateDescription [
	<magritteDescription>
	^ MADateDescription new
		accessor: #reconcileDate;
		yourself
]

{ #category : #accessing }
VsSplit >> status [
	^ self maLazyInstVarUsing: self statusDescription
]

{ #category : #accessing }
VsSplit >> status: anObject [
	status := anObject
]
