accessing
= rhs
	^ self class = rhs class and: [ self partyName = rhs partyName and: [ self partyAliases = rhs partyAliases ] ].