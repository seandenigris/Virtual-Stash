accessing
exampleUSPS
	<gtExample>
	self
		given: 'USPS PO 1234567890'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'USPS' ]
		andMemoAppendedWith: 'PO 1234567890'