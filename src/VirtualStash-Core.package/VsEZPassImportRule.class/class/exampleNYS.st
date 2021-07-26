examples
exampleNYS
	<gtExample>
	self
		given: 'NYS THRUWAY E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]
		andMemoAppendedWith: 'NYS THRUWAY'