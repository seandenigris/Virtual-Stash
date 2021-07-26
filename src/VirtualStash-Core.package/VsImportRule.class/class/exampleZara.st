examples
exampleZara
	<gtExample>
	self
		given: 'ZARA USA 1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Zara' ]
		andMemoAppendedWith: 'USA 1234'