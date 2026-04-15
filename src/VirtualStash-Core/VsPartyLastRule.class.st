Class {
	#name : 'VsPartyLastRule',
	#superclass : 'VsExplicitCounterpartyImportRule',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'testing' }
VsPartyLastRule class >> isAbstract [
	^ self = VsPartyLastRule
]

{ #category : 'as yet unclassified' }
VsPartyLastRule >> memo [
	^ memo ifNil: [ memo := self parsingResult first ]
]

{ #category : 'as yet unclassified' }
VsPartyLastRule >> parser [
	^ parser ifNil: [ parser := VsPartyLastNameParser new ]
]

{ #category : 'as yet unclassified' }
VsPartyLastRule >> paymentProcessor [
	^ nil
]
