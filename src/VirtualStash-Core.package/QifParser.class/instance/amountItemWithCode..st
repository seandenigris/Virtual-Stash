as yet unclassified
amountItemWithCode: aCharacter
	^ self detailItemCode: aCharacter do: [ :e | | withoutCommas |
		withoutCommas := e copyWithout: $,.
		withoutCommas asNumber ].