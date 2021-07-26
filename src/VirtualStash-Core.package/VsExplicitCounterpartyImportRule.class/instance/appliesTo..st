testing
appliesTo: aVsTransaction
	^ (self paymentProcessorParser matches: self partyName) not and: [ super appliesTo: aVsTransaction ].