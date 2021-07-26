examples-support
given: counterpartyString appliedTo: transactionBlock then: assertionBlock
	self
		given: [ | t |
			t := VsTransaction new
				importedName: counterpartyString;
				yourself.
			transactionBlock cull: t.
			t ]
		when: [ :t |
			| matches |
			matches := self all select: [ :e | e appliesTo: t ].
			self assert: matches size equals: 1.
			matches first
				addressBook: MpAddressBook new;
				transaction: t;
				apply;
				yourself ]
		then: assertionBlock