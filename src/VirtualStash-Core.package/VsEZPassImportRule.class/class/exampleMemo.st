examples
exampleMemo
	<gtExample>
	self
		given: 'NEW JERSEY E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]
		andMemoAppendedWith: 'NEW JERSEY'