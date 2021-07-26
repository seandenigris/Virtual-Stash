accessing
exampleTossibleDigitsExtraGibberish
	<gtExample>
	self
		given: 'Tossable Digits Toss'
		appliedTo: [  ]
		then: [ :r :t | 
			self assert: t counterparty name equals: 'Tossable Digits'.
			self assert: t memo isEmpty ]