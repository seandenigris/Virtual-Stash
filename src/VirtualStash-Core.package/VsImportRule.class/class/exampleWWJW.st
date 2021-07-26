examples
exampleWWJW
	<gtExample>
	self
		given: 'Westchester Join PAYMENT    1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Westchester Joint Water Works' ]
		andMemoAppendedWith: 'PAYMENT 1234'