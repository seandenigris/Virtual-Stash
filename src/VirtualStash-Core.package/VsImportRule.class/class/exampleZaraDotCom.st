examples
exampleZaraDotCom
	<gtExample>
	self
		given: 'ZARA.COM.USA'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Zara' ]
		andMemoAppendedWith: 'COM.USA'