ocr-guessing
guessTotal

	| possibilities bestGuess suggestions rankedGuesses |
	possibilities := hocr words select: [ :e | e string matchesRegex: '\$?\d+\.\d\d' ].
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