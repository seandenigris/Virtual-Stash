accessing
exampleBP
	<gtExample>
	self
		given: 'BP#1234567BRONX BP'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'BP' ]
		andMemoAppendedWith: '#1234567BRONX BP'