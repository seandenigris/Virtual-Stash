protocol
possibleDates

	^ self words select: [ :e | e string matchesRegex: '\d\d?/\d\d?/\d\d\d?\d?' ].