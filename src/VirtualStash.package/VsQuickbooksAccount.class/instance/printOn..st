as yet unclassified
printOn: aStream

	aStream
		nextPutAll: name;
		nextPutAll: ' (';
		nextPutAll: type description;
		nextPutAll: ') ';
		nextPutAll: balance asString.