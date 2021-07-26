accessing
exampleDunkinMobile
	<gtExample>
	self
		given: 'DUNKIN'' MOBILE'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Dunkin' ]
		andMemoAppendedWith: 'MOBILE'