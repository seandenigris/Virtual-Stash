accessing
fromGnuCashCode: aString
	| cls |
	cls := self allSubclasses detect: [ :c | c gnuCashCode = aString ].
	^ cls new