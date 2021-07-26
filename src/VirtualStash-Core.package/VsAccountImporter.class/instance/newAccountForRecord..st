accessing
newAccountForRecord: aDictionary
	| cls |
	cls := self recordClass allSubclasses detect: [ :scls | scls gnuCashType = (aDictionary at: #type) ].
	^ cls new