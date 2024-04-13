"
GnuCash transaction export CSV files have rows which may either represent:
- a transaction and a split contained by it
- a split contained by the previous transaction (from a prior row)
"
Class {
	#name : #VsGnuCashTransactionImporter,
	#superclass : #MACSVTwoStageImporter,
	#instVars : [
		'addressBook',
		'books',
		'targetCollection'
	],
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsGnuCashTransactionImporter >> addressBook [
	"By default, leave counterparties as strings, don't convert to domain objects. This is because e.g. GnuCash doesn't have a strong counterparty concept, but a generic description, which could be any unstructured text and might lead to false matches"
	^ addressBook
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> addressBook: anObject [

	addressBook := anObject
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> books [
	^ books
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> books: anObject [
	books := anObject
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> convertToDomainObjects: aCollectionOfDictionaries [
	^ aCollectionOfDictionaries
		inject: OrderedCollection new
		into: [ :col :rowDict | 
			| newTransaction split recordedTransaction |
				
			newTransaction := self initializeTransaction: VsTransaction new fromRecord: rowDict.
			
			split := self initializeSplit: VsSplit new fromRecord: rowDict.
			
			recordedTransaction := newTransaction isValid
				ifTrue: [ col add: newTransaction ]
				ifFalse: [ col last ].
				
			recordedTransaction splits add: split.
			col ]
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> execute [
	| transactions |
	transactions := super execute.
	self targetCollection ifNotNil: [ :col | col addAll: transactions ].
	^ transactions
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> initializeSplit: aSplit fromRecord: aDict [

	aSplit accountSource: self books.
	
	^ self 
		initializeDomainObject: aSplit 
		fromRecord: aDict
		mapping: [ :builder |
			builder
				map: 'Full Account Name' 
					fieldTo: #accountDescription
					using: [ :s | self books accounts detect: [ :accnt |
						accnt gnuCashAccountFullName = s ] ];
				map: 'Amount Num.' 
					fieldTo: #amountDescription
					using: [ :str | str vsAsUSD ];
				map: 'Memo' fieldTo: #memoDescription;
				map: 'Rate/Price' fieldTo: #priceDescription;
				map: 'Reconcile Date' fieldTo: #reconcileDateDescription;
				map: 'Reconcile' 
					fieldTo: #statusDescription
					using: [ :s | VsReconciliationStatus fromGnuCashCode: s ] ].
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> initializeTransaction: aTransaction fromRecord: aDict [
	
	self 
		initializeDomainObject: aTransaction 
		fromRecord: aDict
		mapping: [ :builder |
			builder
				map: 'Date' fieldTo: #dateDescription;
				map: 'Description' fieldTo: #importedNameDescription;
				map: 'Transaction ID' fieldTo: #gnuCashIDDescription;
				map: 'Notes' fieldTo: #memoDescription;
				map: 'Transaction Number' fieldTo: #numberDescription;
				map: 'Void Reason' fieldTo: #voidReasonDescription ].
	
	self addressBook ifNil: [ ^ self ].
	
	aTransaction addressBook: self addressBook.

	self addressBook 
		entryNamed: aTransaction importedName 
		ifFound: [ :e | aTransaction counterparty: e ]
		ifNone: [].
		
	^ aTransaction
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> targetCollection [

	^ targetCollection
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> targetCollection: anObject [

	targetCollection := anObject
]
