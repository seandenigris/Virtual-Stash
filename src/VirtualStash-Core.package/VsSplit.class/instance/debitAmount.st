accessing
debitAmount
	^ self isDebit 
		ifTrue: [ self amount ]
		ifFalse: [ nil ]