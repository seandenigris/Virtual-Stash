accessing
registerString
	^ (self maToString: #dateDescription), '	', (self maToString: #counterpartyDescription), '	', (self maToString: #accountsDescription), '	', (self maToString: #amountDescription)