*Aconcagua-Money
dollars

	| amt |
	amt := ScaledDecimal readFrom: (self copyWithout: $,).
	^ Measure amount: amt unit: AmDollar new