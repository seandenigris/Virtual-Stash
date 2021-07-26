private
amountToString: aNumber
	| intString decimalString |
	intString := '$', aNumber asInteger asStringWithCommas.
	decimalString := aNumber isInteger
		ifTrue: [ '00' ]
		ifFalse: [ (aNumber \\ 1 * 100) asInteger asString ].
	^ aNumber = 0
		ifTrue: [ '' ]
		ifFalse: [ intString , '.' , decimalString ]