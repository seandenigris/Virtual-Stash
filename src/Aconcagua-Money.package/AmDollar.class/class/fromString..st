accessing
fromString: aString
	| parser amount |
	parser := self parser.
	(parser matches: aString) ifFalse: [ self error ].
	amount := (parser subexpression: 2) asNumber.
	^ amount dollars.