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
			newTransaction := VsTransaction new
				accountSource: books;
				yourself.
			self initializeTransaction: newTransaction fromRecord: rowDict.
			split := VsSplit new
				accountSource: books;
				yourself.
			self initializeDomainObject: split fromRecord: rowDict.
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
VsGnuCashTransactionImporter >> initializeTransaction: aTransaction fromRecord: aDict [
	
	self initializeDomainObject: aTransaction fromRecord: aDict.
	
	self addressBook ifNil: [ ^ self ].
	
	aTransaction addressBook: self addressBook.

	self addressBook 
		entryNamed: aTransaction importedName 
		ifFound: [ :e | aTransaction counterparty: e ]
		ifNone: []
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> targetCollection [

	^ targetCollection
]

{ #category : #accessing }
VsGnuCashTransactionImporter >> targetCollection: anObject [

	targetCollection := anObject
]
