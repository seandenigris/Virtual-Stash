initialization-release
initialize
	super initialize.
	paymentProcessor := self addressBook ensureOrganizationNamed: 'Eventbrite'.
	memo := '' "so I don't try to pull one from the parse result (which signals an error)"