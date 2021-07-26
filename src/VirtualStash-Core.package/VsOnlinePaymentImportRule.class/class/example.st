examples
example
	<gtExample>
	
	^ self
		given: 'Online Payment 1234567890 To ABC'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
		andMemoAppendedWith: '1234567890 To ABC'