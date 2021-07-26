accessing
exampleHomeDepot
	<gtExample>
	self
		given: 'THE HOME DEPOT 1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Home Depot' ]
		andMemoAppendedWith: '1234'