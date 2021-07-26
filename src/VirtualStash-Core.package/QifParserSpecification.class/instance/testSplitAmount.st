tests
testSplitAmount
	self
		rule: #splitAmountItem
		parse: '$-2,738.26'
		shouldEqual: -2738.26.
