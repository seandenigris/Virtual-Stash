applying
patchSet: fieldSymbol to: anObject
	self patch 
		addOperationFor: self transaction 
		set: (self transaction perform: fieldSymbol) 
		to: anObject.