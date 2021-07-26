examples-support
givenInput: inputString thenPartyNamed: partyNameString andMemoAppendedWith: memoString
	self
		given: inputString
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: partyNameString ]
		andMemoAppendedWith: memoString