Class {
	#name : #VsExplicitCounterpartyImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsExplicitCounterpartyImportRule class >> examplePaymentProcessor [
	<gtExample>
	self
		given: 'TST* ACME'
		appliedTo: [ ]
		then: [ :r :t | 
			self assert: t counterparty fullName equals: 'Acme'.
			self assert: t processor fullName equals: 'Toast' ]
]

{ #category : #testing }
VsExplicitCounterpartyImportRule class >> isAbstract [
	^ self = VsExplicitCounterpartyImportRule
]

{ #category : #testing }
VsExplicitCounterpartyImportRule >> appliesTo: aVsTransaction [
	^ (self paymentProcessorParser matches: self partyName) not and: [ super appliesTo: aVsTransaction ].
]

{ #category : #applying }
VsExplicitCounterpartyImportRule >> buildPatchOperations [
	super buildPatchOperations.
	self patchSet: #processorDescription to: self paymentProcessor.
]

{ #category : #accessing }
VsExplicitCounterpartyImportRule >> displayName [
	^ self partyName
]

{ #category : #private }
VsExplicitCounterpartyImportRule >> parser [
	| separator |
	separator := ($* asPParser / $- asPParser / #space asPParser) star.
	^ self paymentProcessorParser optional, separator, self partyParser, separator, self extraInfoParser end
]

{ #category : #private }
VsExplicitCounterpartyImportRule >> partyParser [
	^ self party vsNameParser
]

{ #category : #accessing }
VsExplicitCounterpartyImportRule >> paymentProcessor [
	^ paymentProcessor ifNil: [ paymentProcessor := self parsingResult first ]
]

{ #category : #accessing }
VsExplicitCounterpartyImportRule >> paymentProcessor: anMpOrganization [
	paymentProcessor := anMpOrganization
]

{ #category : #accessing }
VsExplicitCounterpartyImportRule >> paymentProcessorParser [
	| processors |
	self flag: 'I seem to remember a pattern to start with a null parser that would simplify this'.
	processors := VsBooks paymentProcessors asOrderedCollection.
	^ processors allButFirst 
		inject: processors first vsNameParser ==> [ :n | processors first ]
		into: [ :result :pp | result / (pp vsNameParser ==> [ :n | pp ]) ]
]

{ #category : #accessing }
VsExplicitCounterpartyImportRule >> printOn: aStream [
	aStream
		nextPutAll: self partyName;
		nextPutAll: ' Party Rule'
]
