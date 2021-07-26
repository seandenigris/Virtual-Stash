as yet unclassified
accountItemWithCode: aCharacter
	| data accountName account category |
	accountName := $] asParser negate plus flatten.
	account := $[ asParser, accountName, $] asParser ==> #second.
	category := ($[ asParser negate, lineSeparator negate plus) flatten. 
	data := account / category.
	^ aCharacter asParser, data, lineSeparator ==> #second.