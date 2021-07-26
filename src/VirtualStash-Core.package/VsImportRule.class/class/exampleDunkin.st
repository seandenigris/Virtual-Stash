accessing
exampleDunkin
	<gtExample>
	self
		given: 'DUNKIN #123456 A23'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Dunkin' ]
		andMemoAppendedWith: '#123456 A23'