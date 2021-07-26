accessing
paymentProcessors
	^ PaymentProcessors ifNil: [ PaymentProcessors := Set new ]