transactions
businessTransaction: transaction
	transaction ifNil: [ ^ self ].
	transaction receipt: self.
	VsBooks business generalJournal add: transaction