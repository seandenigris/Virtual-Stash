examples-support
given: counterpartyString appliedTo: transactionBlock then: assertionBlock andMemoAppendedWith: addedMemo
	| originalMemo |
	self
		given: counterpartyString
		appliedTo: transactionBlock
		then: assertionBlock.
	originalMemo := 'something'.
	self
		given: counterpartyString
		appliedTo: [ :t | 
			transactionBlock cull: t.
			t memo: originalMemo ]
		then: [ :r :t |
			assertionBlock cull: r cull: t.
			self assert: (t memo beginsWith: originalMemo).
			self assert: (t memo endsWith: addedMemo) ]