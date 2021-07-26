examples
example
	"<gtExample>"
	
	^ self
		given: 'Payment Thank You - Web'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
		andMemoAppendedWith: '1234567890 To ABC'