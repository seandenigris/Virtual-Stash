accessing
exampleTarget
	<gtExample>
	self
		given: 'TARGET        12345678'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Target' ]
		andMemoAppendedWith: '12345678'