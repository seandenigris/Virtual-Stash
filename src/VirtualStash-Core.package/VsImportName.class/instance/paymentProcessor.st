accessing
paymentProcessor
	^ self
		ruleIfFound: [ :r | r paymentProcessor ]
		ifNone: [ 
			| nameTokens |
			nameTokens := self string findTokens: '*'.
			VsBooks paymentProcessors 
				detect: [ :e | (e aliases copyWith: e name) anySatisfy: [ :pn | pn asUppercase = nameTokens first trimBoth asUppercase ] ]
			ifNone: [ nil ] ]