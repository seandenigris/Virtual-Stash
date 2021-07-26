accessing
counterpartyName
	| nameTokens |
	nameTokens := self string findTokens: '*'.
	^ self paymentProcessor
		ifNil: [ self string ]
		ifNotNil: [ :p | nameTokens second trimBoth ].