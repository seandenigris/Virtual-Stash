accessing
convertToDomainObjects: aCollectionOfDictionaries
	| result |
	result := aCollectionOfDictionaries collect: [ :e | 
		| account |
		account := self newAccountForRecord: e.
		self initializeDomainObject: account fromRecord: e.
		account ].
		
	"This is done at the end because we can't set the parents until we create all the account objects"
	self fixParentsOf: result.
	^ result