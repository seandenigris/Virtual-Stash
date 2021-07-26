accessing
exampleProcessor
	| result |
	result := self new
		string: 'TST* THE VENDOR';
		yourself.
	self assert: (result paymentProcessor aliases includes: 'TST').
	^ result