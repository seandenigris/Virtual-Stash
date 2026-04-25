Class {
	#name : 'VsPartyNameParser',
	#superclass : 'PP2CompositeNode',
	#instVars : [
		'separatorParser',
		'paymentProcessorParser',
		'partyParser',
		'primaryParser',
		'extraInfoParser',
		'parser',
		'party',
		'paymentProcessorFirstParser',
		'partyFirstParser'
	],
	#category : 'VirtualStash-Core',
	#package : 'VirtualStash-Core'
}

{ #category : 'accessing' }
VsPartyNameParser class >> ignoredNames [

  ^ super ignoredNames, #(party)
]

{ #category : 'grammar' }
VsPartyNameParser >> extraInfoParser [

  ^ #any asPParser plus flatten trimBlanks
    ==> [ :n | n ifNotNil: [ :s | s withBlanksCondensed ] ]
]

{ #category : 'grammar' }
VsPartyNameParser >> parser [

  ^ (paymentProcessorFirstParser / partyFirstParser) end
]

{ #category : 'accessing' }
VsPartyNameParser >> party [

  ^ party
]

{ #category : 'accessing' }
VsPartyNameParser >> party: anMpRelatableEntity [

  party := anMpRelatableEntity.
  partyParser child: anMpRelatableEntity vsNameParser
]

{ #category : 'grammar' }
VsPartyNameParser >> partyFirstParser [

  ^ partyParser, extraInfoParser, separatorParser, extraInfoParser
]

{ #category : 'grammar' }
VsPartyNameParser >> partyParser [

  ^ PP2DelegateNode new
  	
  "Tried:
  - `PP2DelegateNode on: [ self party vsNameParser ]`, but it won't accept a block`
  - `PP2PluggableNode new
  	block: [ :context | self party vsNameParser parseWithContext: context ]` but returned a context, not a result (might need to explicitly return result from context in the block"
]

{ #category : 'grammar' }
VsPartyNameParser >> paymentProcessorFirstParser [

  ^ paymentProcessorParser , separatorParser ==> #first , partyParser
]

{ #category : 'grammar' }
VsPartyNameParser >> paymentProcessorParser [

  ^ VsBooks paymentProcessors asOrderedCollection
      inject: #failure asPParser
      into: [ :result :pp | result / ( pp vsNameParser ==> [ :n | pp ] ) ]
]

{ #category : 'grammar' }
VsPartyNameParser >> primaryParser [

  ^ ( paymentProcessorParser , separatorParser ==> #first ) optional , partyParser
]

{ #category : 'grammar' }
VsPartyNameParser >> separatorParser [

  ^ $* asPParser / $- asPParser , Character space asPParser star
]

{ #category : 'accessing' }
VsPartyNameParser >> start [
	^ parser
]
