accessing
exampleTJMaxx
	<gtExample>
	self
		given: 'TJMAXX #1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'T.J. Maxx' ]
		andMemoAppendedWith: '#1234'