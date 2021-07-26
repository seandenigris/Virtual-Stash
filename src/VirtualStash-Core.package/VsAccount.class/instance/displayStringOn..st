accessing
displayStringOn: aStream
	aStream nextPutAll: self name.
	self pathString ifNotEmpty: [ :str |
		aStream
			nextPutAll: ' (';
			nextPutAll: str;
			nextPut: $) ]