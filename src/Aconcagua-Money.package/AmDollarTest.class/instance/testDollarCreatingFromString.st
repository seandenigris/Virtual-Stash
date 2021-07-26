accessing
testDollarCreatingFromString
	AmDollar fromString: '$1.00'.
	self should: [ AmDollar fromString: '$1.0a' ] raise: Error