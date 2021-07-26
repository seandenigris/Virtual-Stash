tests
testDate
	self
		rule: #dateItem
		parse: 'D1/30''2004'
		shouldEqual: '1/30/2004' asDate