tests
testMemo
	self
		rule: #memoItem
		parse: 'MPAY AT PUMP2339483498349'
		shouldEqual: 'PAY AT PUMP2339483498349'