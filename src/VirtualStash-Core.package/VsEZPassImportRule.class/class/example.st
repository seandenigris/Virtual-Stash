examples
example
	<gtExample>
	self
		given: 'E-ZPASS'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'E-ZPass' ]