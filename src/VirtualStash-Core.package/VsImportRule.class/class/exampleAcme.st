accessing
exampleAcme
	<gtExample>
	self
		givenInput: 'ACME #1234'
		thenPartyNamed: 'Acme'
		andMemoAppendedWith: '#1234'