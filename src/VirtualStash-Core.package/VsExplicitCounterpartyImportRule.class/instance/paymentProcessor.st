accessing
paymentProcessor
	^ paymentProcessor ifNil: [ paymentProcessor := self parsingResult first ]