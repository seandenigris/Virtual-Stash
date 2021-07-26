helpers
testDetail: aString
	| parser result |

	parser := QifParser new detail end.
	result := parser parse: aString.
	result isPetitFailure should beFalse