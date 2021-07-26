accessing
partyParser
	| prefixWord result |
	prefixWord := self separatorParser negate star flatten.
	result := (1 to: self prefixWordCount - 1)
		inject: prefixWord
		into: [ :p :e | p , self separatorParser , prefixWord ].
	^ result flatten