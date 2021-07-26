as yet unclassified
detailItemCode: aCharacter do: aBlock
	| data |
	data := lineSeparator negate star flatten ==> aBlock.
	^ aCharacter asParser, data, lineSeparator ==> #second.