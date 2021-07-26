accessing
printOn: aStream
	aStream nextPutAll: (self className allButFirst: 2) normalizeCamelCase