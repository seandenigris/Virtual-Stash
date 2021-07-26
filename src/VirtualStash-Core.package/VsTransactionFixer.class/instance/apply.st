accessing
apply
	| party |
	party := MpOrganization ensureNamed: self counterparty.
	self applyAliasTo: party.
	self transaction
		counterparty: party;
		memoAppend: self suffix.