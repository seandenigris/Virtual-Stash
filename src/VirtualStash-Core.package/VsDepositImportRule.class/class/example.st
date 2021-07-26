accessing
example
	<gtExample>
	
	self
		given: 'REMOTE ONLINE DEPOSIT #'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]