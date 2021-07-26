magritte-accessing
amountToString: aNumber
	| intString decimalString |
	intString := aNumber asInteger asStringWithCommas.
	decimalString := aNumber isInteger
		ifTrue: [ '00' ]
		ifFalse: [ (aNumber \\ 1 * 100) asInteger printPaddedWith: $0 to: 2  ].
	^ aNumber = 0
		ifTrue: [ '' ]
		ifFalse: [ intString , '.' , decimalString ]