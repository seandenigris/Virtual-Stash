Class {
	#name : #VsAmexTransactionImporter,
	#superclass : #MACSVTwoStageImporter,
	#instVars : [
		'addressBook',
		'books',
		'targetCollection'
	],
	#category : #'VirtualStash-Core-Importing-Amex'
}

{ #category : #accessing }
VsAmexTransactionImporter >> addressBook [
	"By default, leave counterparties as strings, don't convert to domain objects. This is because e.g. GnuCash doesn't have a strong counterparty concept, but a generic description, which could be any unstructured text and might lead to false matches"
	^ addressBook
]

{ #category : #accessing }
VsAmexTransactionImporter >> addressBook: anObject [

	addressBook := anObject
]

{ #category : #accessing }
VsAmexTransactionImporter >> books [
	^ books
]

{ #category : #accessing }
VsAmexTransactionImporter >> books: anObject [
	books := anObject
]

{ #category : #API }
VsAmexTransactionImporter >> convertToDomainObjects: aCollectionOfDictionaries [

	^ aCollectionOfDictionaries collect: [ :rowDict | 
		| newTransaction split |
		newTransaction := self transactionInitializedFromRecord: rowDict.
		split := self splitInitializedFromRecord: rowDict.
		
		"We pass the transaction here (we didn't for split) because the address may or may not be added to the transaction as part of processing the fields"
		self
			initializeAddressOf: newTransaction 
			fromRecord: rowDict.
			
		newTransaction splits add: split.
		newTransaction ]
]

{ #category : #executing }
VsAmexTransactionImporter >> execute [
	| transactions |
	transactions := super execute.
	self targetCollection ifNotNil: [ :col | col addAll: transactions ].
	^ transactions
]

{ #category : #accessing }
VsAmexTransactionImporter >> fieldMap [
	| fieldData |
	fieldData := {
		{ 'Amount'. #amount. #split }.
		{ 'Extended Details'. #memo. nil }.
		{ 'Appears On Your Statement As'. #amexStatementDescription. nil }.
		{ 'Address'. #streetAddress. #address }.
		{ 'City/State'. #amexCityAndState. #address }.
		{ 'Zip Code'. #zipCode. #address }.
		{ 'Country'. nil. #none }.
		{ 'Category'. #amexCategory. nil }
	}.
	
	^ fieldData collect: [ :col |
		VsCSVImporterField new
			csvFieldName: col first;
			descriptionName: col second;
			group: col third;
			yourself ]
]

{ #category : #private }
VsAmexTransactionImporter >> initializeAddressOf: aTransaction fromRecord: aDictionary [

	| address usaAliases country |
	country := (aDictionary at: 'Country') ifNil: [ ^ self ].
		
	usaAliases := #('UNITED STATES OF AMERICA (THE)' 'UNITED STATES').
	(usaAliases includes: country) ifFalse: [ self error: 'No model for international addresses' ].
	
	address := MpUSAddress new
		addTalent: VsTAmexAddress during: [
			self 
				initializeDomainObject: address
				fromRecord: aDictionary 
				group: #address
				ignoringUnmapped: true ].
	
	aTransaction propertyAt: #amexAddress put: address
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeDomainObject: anObject fromRecord: aDictionary [
	
	^ self 
		initializeDomainObject: anObject
	 	fromRecord: aDictionary 
	 	group: nil
	 	ignoringUnmapped: false
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeDomainObject: anObject fromRecord: aDictionary group: aSymbol ignoringUnmapped: ignoreUnmappedBoolean [
	
	aDictionary keysAndValuesDo: [ :k :stringValue |
		| field |
		field := self fieldMap
			detect: [ :e | e csvFieldName = k ]
			ifNone: [ 
				ignoreUnmappedBoolean
					ifTrue: [ nil ]
					ifFalse: [ 
						VsCSVImporterField new
						csvFieldName: k;
						descriptionName: k uncapitalized asSymbol;
						yourself ] ].
		(field isNotNil and: [ field group = aSymbol ]) ifTrue: [ 
			field write: stringValue to: anObject ] ].
	
	^ anObject
	
	"Implementation note: Used to be a class-side utility method, but we needed an instance-side version because some objects may need configuration during instance creation"
]

{ #category : #accessing }
VsAmexTransactionImporter >> splitInitializedFromRecord: aDictionary [

	| result |
	result := VsSplit new.
			
	^ self
		initializeDomainObject: result 
			fromRecord: aDictionary 
			group: #split 
			ignoringUnmapped: true.
]

{ #category : #accessing }
VsAmexTransactionImporter >> targetCollection [

	^ targetCollection
]

{ #category : #accessing }
VsAmexTransactionImporter >> targetCollection: anObject [

	targetCollection := anObject
]

{ #category : #accessing }
VsAmexTransactionImporter >> transactionInitializedFromRecord: aDict [

	| result |
	result := VsTransaction new
		accountSource: books;
		addTalent: VsTAmexTransaction 
			during: [ :trns |
				self 
					initializeDomainObject: trns 
					fromRecord: aDict ];
		yourself.
	
	self addressBook ifNil: [ ^ result ].
	
	result addressBook: self addressBook.
	
	self addressBook 
		entryNamed: result counterparty 
		ifFound: [ :e | result counterparty: e ]
		ifNone: [].
		
	^ result
]
