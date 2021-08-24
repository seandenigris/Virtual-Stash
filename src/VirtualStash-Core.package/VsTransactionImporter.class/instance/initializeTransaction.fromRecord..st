accessing
initializeTransaction: aTransaction fromRecord: aDict
	
	self initializeDomainObject: aTransaction fromRecord: aDict.
	
	self addressBook ifNil: [ ^ self ].
	
	aTransaction addressBook: self addressBook.
	self addressBook 
		entryNamed: aTransaction counterparty 
		ifFound: [ :e | aTransaction counterparty: e ]
		ifNone: []