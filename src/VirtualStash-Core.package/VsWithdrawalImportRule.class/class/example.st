examples
example
	"<gtExample>"
	self flag: 'need a way to stub addressbook with user/cash account'.
	^ self
		given: 'WITHDRAWAL'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]