accessing
for: aTransaction
	^ self all 
		detect: [ :e | e appliesTo: aTransaction ]
		ifFound: [ :r | 
			r
				transaction: aTransaction;
				yourself ]
		ifNone: [ nil ]