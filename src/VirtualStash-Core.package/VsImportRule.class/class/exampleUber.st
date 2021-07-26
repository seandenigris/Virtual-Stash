examples
exampleUber
	<gtExample>
	self
		given: 'Uber.Com'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Uber' ]
		andMemoAppendedWith: '.Com'