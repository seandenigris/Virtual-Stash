accessing
gnuCashType
	| prefixSize |
	prefixSize := 2.
	^ (self name allButFirst: prefixSize) asUppercase allButLast: 'Account' size