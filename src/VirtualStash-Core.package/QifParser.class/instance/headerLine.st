rules
headerLine
	| accountType |
	accountType := lineSeparator negate plus flatten.
	^ '!Type:' asParser, accountType, lineSeparator ==> #second