Class {
	#name : 'VsPartyLastNameParser',
	#superclass : 'VsPartyNameParser',
	#category : 'VirtualStash-Core',
	#package : 'VirtualStash-Core'
}

{ #category : 'as yet unclassified' }
VsPartyLastNameParser >> parser [
	^ extraInfoParser, separatorParser, partyParser end
]
