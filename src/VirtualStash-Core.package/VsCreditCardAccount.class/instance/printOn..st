printing
printOn: aStream

	aStream nextPutAll: name.
	self number ifNotNil: [ 
		aStream 
			nextPutAll: ' (... ';
			nextPutAll: self lastFour;
			nextPut: $) ]