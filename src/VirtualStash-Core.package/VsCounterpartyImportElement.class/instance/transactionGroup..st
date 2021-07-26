accessing
transactionGroup: anObject
	| counterpartySuggestion nameTokens |
	transactionGroup := anObject.
	editorInputElement text: self transactionGroup input suggestion.
	memoInputElement text: self transactionGroup memo.
	self paymentProcessor ifNotNil: [ :p | paymentProcessorInputElement text: p displayString ].
	matchList items: self transactionGroup rankedMatches.