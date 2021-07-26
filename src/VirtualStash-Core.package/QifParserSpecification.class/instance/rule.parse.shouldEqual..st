helpers
rule: selector parse: aString shouldEqual: anObject
	| parser result |
	parser := QifParser new perform: selector.
	result := parser end parse: aString, Character cr asString.
	result should equal: anObject