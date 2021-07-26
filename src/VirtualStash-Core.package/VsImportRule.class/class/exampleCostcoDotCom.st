accessing
exampleCostcoDotCom
	<gtExample>
	self
		given: 'WWW COSTCO COM'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Costco' ]
		andMemoAppendedWith: 'COM'