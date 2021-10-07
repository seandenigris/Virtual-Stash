Class {
	#name : #VsTransactionImporter,
	#superclass : #MACSVTwoStageImporter,
	#instVars : [
		'addressBook',
		'books',
		'targetCollection'
	],
	#category : 'VirtualStash-Core'
}

{ #category : #accessing }
VsTransactionImporter >> addressBook [
	"By default, leave counterpartys as strings, don't convert to domain objects. This is because e.g. GnuCash doesn't have a strong counterparty concept, but a generic description, which could be any unstructured text and might lead to false matches"
	^ addressBook
]

{ #category : #accessing }
VsTransactionImporter >> addressBook: anObject [

	addressBook := anObject
]

{ #category : #accessing }
VsTransactionImporter >> books [
	^ books
]

{ #category : #accessing }
VsTransactionImporter >> books: anObject [
	books := anObject
]

{ #category : #accessing }
VsTransactionImporter >> convertToDomainObjects: aCollectionOfDictionaries [
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
VsTransactionImporter >> execute [
	| transactions |
	transactions := super execute.
	self targetCollection ifNotNil: [ :col | col addAll: transactions ].
	^ transactions
]

{ #category : #accessing }
VsTransactionImporter >> initializeTransaction: aTransaction fromRecord: aDict [
	
	self initializeDomainObject: aTransaction fromRecord: aDict.
	
	self addressBook ifNil: [ ^ self ].
	
	aTransaction addressBook: self addressBook.
	self addressBook 
		entryNamed: aTransaction counterparty 
		ifFound: [ :e | aTransaction counterparty: e ]
		ifNone: []
]

{ #category : #accessing }
VsTransactionImporter >> targetCollection [

	^ targetCollection
]

{ #category : #accessing }
VsTransactionImporter >> targetCollection: anObject [

	targetCollection := anObject
]
