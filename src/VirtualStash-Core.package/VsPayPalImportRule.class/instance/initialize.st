initialization-release
initialize
	super initialize.
	paymentProcessor := self addressBook ensureOrganizationNamed: 'PayPal'