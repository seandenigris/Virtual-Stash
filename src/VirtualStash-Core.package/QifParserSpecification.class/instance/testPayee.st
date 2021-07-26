tests
testPayee
	self
		rule: #payeeItem
		parse: 'PAmerican Express'
		shouldEqual: 'American Express'