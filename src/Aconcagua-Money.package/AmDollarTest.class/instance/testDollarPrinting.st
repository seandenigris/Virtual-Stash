accessing
testDollarPrinting
	self
		assert: self testDollarCreatingFromNumber printString
		equals: '$1.00 USD'.
	self
		assert: self testDollarCreatingMultipleFromNumber printString
		equals: '$10.00 USD'