accessing
exampleTargetDotCom
	<gtExample>
	self
		given: 'TARGET.COM  *'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Target' ]
		andMemoAppendedWith: '.COM *'