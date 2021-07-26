accessing
creditAmount
	^ self isCredit 
		ifTrue: [ 
			self amount * -1;
				yourself ]
		ifFalse: [ nil ]