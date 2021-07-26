examples
exampleWholeFoods
	<gtExample>
	self
		given: 'WHOLEFDS ABC#12345'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Whole Foods' ]
		andMemoAppendedWith: 'ABC#12345'