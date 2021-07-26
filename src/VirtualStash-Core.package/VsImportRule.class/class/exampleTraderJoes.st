accessing
exampleTraderJoes
	<gtExample>
	self
		given: 'TRADER JOE''S #123 ABC'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Trader Joe''s' ]
		andMemoAppendedWith: '#123 ABC'