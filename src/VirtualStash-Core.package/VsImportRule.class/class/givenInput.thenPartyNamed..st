examples-support
givenInput: inputString thenPartyNamed: partyNameString
	self
		given: inputString
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: partyNameString ]