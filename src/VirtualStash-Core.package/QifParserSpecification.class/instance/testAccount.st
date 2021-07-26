tests
testAccount
	self
		rule: #accountItem
		parse: 'L[Landscaping Reimbursible Expense]'
		shouldEqual: 'Landscaping Reimbursible Expense'.
	self
		rule: #accountItem
		parse: 'LTravel-Vacation:Lodging'
		shouldEqual: 'Travel-Vacation:Lodging'.