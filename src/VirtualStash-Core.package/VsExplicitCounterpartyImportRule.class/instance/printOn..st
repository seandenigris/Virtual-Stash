accessing
printOn: aStream
	aStream
		nextPutAll: self partyName;
		nextPutAll: ' Party Rule'