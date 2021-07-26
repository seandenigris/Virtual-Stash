accessing
new
	^ super new
		initializeBaseUnit: AmCent new
		conversionFactor: 100
		nameForOne: 'dollar'
		nameForMany: 'dollars'
		sign: 'USD'