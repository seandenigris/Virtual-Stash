accessing
exampleCostco
	<gtExample>
	self
		given: 'COSTCO WHSE #1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Costco' ]
		andMemoAppendedWith: 'WHSE #1234'