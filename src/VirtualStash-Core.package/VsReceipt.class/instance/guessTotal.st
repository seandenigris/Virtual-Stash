ocr-guessing
guessTotal

	| possibilities bestGuess suggestions rankedGuesses optionalDollarSign oneOrMoreDigits moneyRegex |
	optionalDollarSign := '\$?'.
	oneOrMoreDigits := '\d+'.
	moneyRegex := optionalDollarSign, oneOrMoreDigits, '\.\d\d'.
	possibilities := hocr words select: [ :e | e string matchesRegex: moneyRegex ].
	possibilities := possibilities asOrderedCollection.
	rankedGuesses := possibilities sort: [ :a :b | | aNumeric bNumeric |
		aNumeric := a string copyWithout: $$.
		bNumeric := b string copyWithout: $$.
		aNumeric asNumber > bNumeric asNumber ].
	bestGuess := rankedGuesses first.
	suggestions := VsReceiptFieldSuggestions on: possibilities.
	^ suggestions
		bestGuess: bestGuess;
		yourself.