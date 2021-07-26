transactions
personalTransaction
	^ VsBooks personal generalJournal transactions
			detect: [ :e | e receipt == self ]
			ifNone: [ nil ]