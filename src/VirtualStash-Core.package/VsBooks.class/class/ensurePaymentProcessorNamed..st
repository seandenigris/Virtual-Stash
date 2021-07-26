accessing
ensurePaymentProcessorNamed: aString
	| p |
	p := MpAddressBook default ensureOrganizationNamed: aString.
	^ self paymentProcessors add: p.