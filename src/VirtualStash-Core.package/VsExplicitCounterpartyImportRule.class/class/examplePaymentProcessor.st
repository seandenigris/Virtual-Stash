accessing
examplePaymentProcessor
	<gtExample>
	self
		given: 'TST* ACME'
		appliedTo: [ ]
		then: [ :r :t | 
			self assert: t counterparty fullName equals: 'Acme'.
			self assert: t processor fullName equals: 'Toast' ]