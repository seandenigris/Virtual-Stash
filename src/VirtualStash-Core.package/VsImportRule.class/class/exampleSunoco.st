accessing
exampleSunoco
	<gtExample>
	self
		given: 'SUNOCO 1234567890'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Sunoco' ]
		andMemoAppendedWith: '1234567890'