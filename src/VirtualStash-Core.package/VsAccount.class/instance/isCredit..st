utilities
isCredit: aNumber
	^ self normalBalance = #credit
		ifTrue: [ aNumber > 0 ]
		ifFalse: [ aNumber < 0 ]