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

{ #category : #accessing }
VsAmexTransactionImporter >> convertToDomainObjects: aCollectionOfDictionaries [
	^ aCollectionOfDictionaries collect: [ :rowDict | 
		| newTransaction split |
		newTransaction := VsTransaction new
			accountSource: books;
			addTalent: VsTAmexTransaction;
			yourself.
			
		split := VsSplit new
			"addTalent: VsTAmexSplit;"
			yourself.
			
		self 
			initializeDomainObject: newTransaction fromRecord: rowDict;
			initializeDomainObject: split fromRecord: rowDict group: #split ignoringUnmapped: true;
			initializeAddressOf: newTransaction fromRecord: rowDict.
		newTransaction removeTalent: VsTAmexTransaction.
		newTransaction splits add: split.
		newTransaction ]
]

{ #category : #accessing }
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
			target: col second;
			group: col third;
			yourself ]
]

{ #category : #accessing }
VsAmexTransactionImporter >> ignoredFields [
	^ #('Address' 'City/State' 'Zip Code' 'Country')
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeAddressOf: aTransaction fromRecord: aDictionary [

	| address usaAliases country ignoredFields |
	country := (aDictionary at: 'Country') ifNil: [ ^ self ].
		
	usaAliases := #('UNITED STATES OF AMERICA (THE)' 'UNITED STATES').
	(usaAliases includes: country) ifFalse: [ self error: 'No model for international addresses' ].
	
	address := MpUSAddress new
		addTalent: VsTAmexAddress;
		yourself.
	
	ignoredFields := self fieldMap reject: [ :e | self ignoredFields includes: e csvFieldName ].
	ignoredFields := ignoredFields collect: #csvFieldName.
	self 
		initializeDomainObject: address
		fromRecord: aDictionary 
		group: #address
		ignoringUnmapped: true.
		
	address removeTalent: VsTAmexAddress.
	
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
						target: k uncapitalized asSymbol;
						yourself ] ].
		(field isNotNil and: [ field group = aSymbol ]) ifTrue: [ 
			field write: stringValue to: anObject ] ].
	
	^ anObject
	
	"Implementation note: Used to be a class-side utility method, but we needed an instance-side version because some objects may need configuration during instance creation"
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeDomainObject: anObject fromRecord: aDictionary ignoring: fieldNames andUnmapped: ignoreUnmappedBoolean [
	
	aDictionary keysAndValuesDo: [ :k :stringValue |
		(fieldNames includes: k) 
			ifFalse: [ 
				| field |
				field := self fieldMap
					detect: [ :e | e csvFieldName = k ]
					ifNone: [ 
						ignoreUnmappedBoolean
							ifTrue: [ nil ]
							ifFalse: [ 
								VsCSVImporterField new
								csvFieldName: k;
								target: k uncapitalized asSymbol;
								yourself ] ].
				field ifNotNil: [ field write: stringValue to: anObject ] ] ].
	
	^ anObject
	
	"Implementation note: Used to be a class-side utility method, but we needed an instance-side version because some objects may need configuration during instance creation"
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeMagritteFieldsOfDomainObject: anObject fromRecord: aDictionary [
	"We needed an instance-side version because some objects may need configuration during instance creation"
	anObject magritteDescription do: [ :desc | 
		desc
			propertyAt: #csvFieldName
			ifPresent: [ :fieldName | 
				| stringValue value |
				stringValue := aDictionary at: fieldName.
				self flag: 'This next part looks very memento-like'.
				stringValue ifNotNil: [ 
					value := desc csvReader value: stringValue.
					desc write: value to: anObject ] ] ].
	^ anObject
]

{ #category : #accessing }
VsAmexTransactionImporter >> initializeTransaction: aTransaction fromRecord: aDict [
	
	self initializeDomainObject: aTransaction fromRecord: aDict.
	
	self addressBook ifNil: [ ^ self ].
	
	aTransaction addressBook: self addressBook.
	self addressBook 
		entryNamed: aTransaction counterparty 
		ifFound: [ :e | aTransaction counterparty: e ]
		ifNone: []
]

{ #category : #accessing }
VsAmexTransactionImporter >> targetCollection [

	^ targetCollection
]

{ #category : #accessing }
VsAmexTransactionImporter >> targetCollection: anObject [

	targetCollection := anObject
]
