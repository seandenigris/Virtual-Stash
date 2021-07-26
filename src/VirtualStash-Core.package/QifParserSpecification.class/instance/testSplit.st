tests
testSplit
	self
		rule: #split
		parse: 'SPersonal Care
Etoothpaste
$-3.38'
		shouldEqual: { 'Personal Care'. 'toothpaste'. -3.38 }.
