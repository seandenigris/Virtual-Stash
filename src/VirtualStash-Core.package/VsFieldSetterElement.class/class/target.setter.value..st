accessing
target: anObject setter: aSymbol value: anotherObject
	^ self basicNew
		target: anObject;
		setter: aSymbol;
		argument: anotherObject;
		initialize.
	