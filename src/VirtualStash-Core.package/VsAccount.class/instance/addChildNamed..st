accessing
addChildNamed: aString
	| child |
	child := (self class named: aString)
		parent: self;
		yourself.
	^ self books chartOfAccounts add: child