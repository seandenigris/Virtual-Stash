transactions
businessTransaction
	^ VsBooks business generalJournal transactions
			detect: [ :e | e receipt == self ]
			ifNone: [ nil ]