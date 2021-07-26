accessing
party
	^ party ifNil: [ self addressBook ensureOrganizationNamed: self partyName ].