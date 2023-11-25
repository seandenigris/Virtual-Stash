Class {
	#name : #VsOfxTransactionImporter,
	#superclass : #MACSVTwoStageImporter,
	#instVars : [
		'account',
		'imbalanceAccount',
		'books'
	],
	#category : #'VirtualStash-Core-OFX'
}

{ #category : #accessing }
VsOfxTransactionImporter >> account [
	^ account
]

{ #category : #accessing }
VsOfxTransactionImporter >> account: anObject [
	account := anObject
]

{ #category : #accessing }
VsOfxTransactionImporter >> books [
	^ books
]

{ #category : #accessing }
VsOfxTransactionImporter >> books: anObject [
	books := anObject
]

{ #category : #accessing }
VsOfxTransactionImporter >> domainObjectFromDictionary: aDictionary [
	| transaction split imbalanceSplit |
	
	transaction := self initializeTransactionFromDictionary: aDictionary.
	
	split := self 
		initializeSplitWithAccount: self account 
		usingReader: #dollars 
		fromDictionary: aDictionary.
		
	imbalanceSplit := self 
		initializeSplitWithAccount: self imbalanceAccount 
		usingReader: [ :str | str dollars negated ]
		fromDictionary: aDictionary.
		
	transaction splits 
		add: split;
		add: imbalanceSplit.
	
	^ transaction
]

{ #category : #accessing }
VsOfxTransactionImporter >> imbalanceAccount [
	^ imbalanceAccount
]

{ #category : #accessing }
VsOfxTransactionImporter >> imbalanceAccount: anObject [
	imbalanceAccount := anObject
]

{ #category : #accessing }
VsOfxTransactionImporter >> initializeDomainObject: anObject fromRecord: aDictionary mapping: mapBlock descriptionDo: descriptionBlock [
	"
	anObject - domain object to be initialized
	aDictionary - keys are CSV column names
	mapBlock - use to modify existing descriptions; argument will be an MACSVMappingPragmaBuilder to configure
	descriptionBlock - argument is the container description for anObject, for further configuration e.g. adding an element description"
	
	| contDesc builder |
	builder := MACSVMappedPragmaBuilder new
		fieldNamePropertyKey: self fieldNamePropertyKey;
		fieldReaderPropertyKey: self fieldReaderPropertyKey;
		yourself.
	mapBlock value: builder.
		
	contDesc := builder for: anObject.
	descriptionBlock value: contDesc.
	
	aDictionary keysAndValuesDo: [ :key :val |
		contDesc children 
			detect: [ :d | 
				d
					propertyAt: self fieldNamePropertyKey
					ifPresent: [ :fieldName | fieldName = key ]
					ifAbsent: [ false ] ]
			ifFound: [ :desc |
				| stringValue value fieldReader |
				stringValue := aDictionary at: key.
				self flag: 'This next part looks very memento-like'.
				stringValue ifNotNil: [ 
					fieldReader := desc 
						propertyAt: self fieldReaderPropertyKey
						ifAbsent: [ desc csvReader ].
					value := fieldReader cull: stringValue cull: desc.
					desc write: value to: anObject ] ] ].
	^ anObject
]

{ #category : #accessing }
VsOfxTransactionImporter >> initializeSplitWithAccount: anAccount usingReader: aReader fromDictionary: aDictionary [
	| split |
	split := VsSplit new
		accountSource: self books;
		account: anAccount;
		yourself.
	
	^ self
		initializeDomainObject: split
		fromRecord: aDictionary
		mapping: [ :builder | 
			builder
				map: 'TRNAMT'
				fieldTo: #amountDescription
				using: aReader ]
]

{ #category : #accessing }
VsOfxTransactionImporter >> initializeTransactionFromDictionary: aDictionary [

	| transaction |
	transaction := VsTransaction new.
	
	aDictionary keysAndValuesDo: [ :key :val |
		(self mappedFields includes: key) ifFalse: [
			transaction
				propertyAt: 'ofx', key
				put: val ] ].
	^ self
		initializeDomainObject: transaction
		fromRecord: aDictionary
		mapping: [ :builder | 
			builder
				map: 'DTPOSTED'
					fieldTo: #dateDescription
					using: [ :input | (VsOfxDatetimeParser parse: input) asDate ];
				map: 'NAME' fieldTo: #importedNameDescription;
				map: 'MEMO' fieldTo: #memoDescription;
				map: 'CHECKNUM' fieldTo: #numberDescription ]
]

{ #category : #accessing }
VsOfxTransactionImporter >> mappedFields [

	^ #(TRNAMT DTPOSTED NAME MEMO CHECKNUM)
	
	"Motivation: we want to store unhandled fields as properties, but some fields belong to the transactions themselves and some belong to the splits they contain, so we need a list containing both classes of fields to know which other fields to store as properties"
]
