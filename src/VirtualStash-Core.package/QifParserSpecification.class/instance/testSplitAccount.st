tests
testSplitAccount
	self
		rule: #splitAccountItem
		parse: 'S[Landscaping Reimbursible Expense]'
		shouldEqual: 'Landscaping Reimbursible Expense'.
	self
		rule: #splitAccountItem
		parse: 'STravel-Vacation:Lodging'
		shouldEqual: 'Travel-Vacation:Lodging'.