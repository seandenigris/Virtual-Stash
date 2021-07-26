*Aconcagua-Money
cents

	| amt |
	amt := ScaledDecimal readFrom: (self copyWithout: $,).
	^ Measure amount: amt unit: AmCent new