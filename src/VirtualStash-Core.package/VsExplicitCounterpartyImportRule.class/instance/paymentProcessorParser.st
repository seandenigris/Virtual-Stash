accessing
paymentProcessorParser
	| processors |
	self flag: 'I seem to remember a pattern to start with a null parser that would simplify this'.
	processors := VsBooks paymentProcessors asOrderedCollection.
	^ processors allButFirst 
		inject: processors first vsNameParser ==> [ :n | processors first ]
		into: [ :result :pp | result / (pp vsNameParser ==> [ :n | pp ]) ]