accessing
testPrinting
	self
		assert: self testCreatingOneFromNumber printString
		equals: '1 cent'.
	self
		assert: self testCreatingMultipleFromNumber printString
		equals: '10 cents'