accessing
exampleDunkinDonuts
	<gtExample>
	self
		given: 'Dunkin Donuts'
		appliedTo: [  ]
		then: [ :r :t | 
			self assert: t counterparty name equals: 'Dunkin'.
			self assert: t memo equals: '' ]