examples
example
	<gtExample>
	
	self
		given: 'CHECK 101'
		appliedTo: [ ]
		then: [ :r :t | self assert: t number equals: '101' ]
		andMemoAppendedWith: 'Check'