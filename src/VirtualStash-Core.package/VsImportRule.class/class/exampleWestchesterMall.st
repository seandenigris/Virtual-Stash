examples
exampleWestchesterMall
	<gtExample>
	self
		given: 'THE WESTCHESTER MALL PARK'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Westchester Mall' ]
		andMemoAppendedWith: 'PARK'