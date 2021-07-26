initialization-release
initialize
	super initialize.
	paymentProcessor := self addressBook ensureOrganizationNamed: 'Chase'.
	memo := 'Quick Pay'