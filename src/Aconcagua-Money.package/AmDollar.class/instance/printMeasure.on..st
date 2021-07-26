printing
printMeasure: aMeasure on: aStream

	aStream nextPut: $$.
	aStream nextPutAll: (aMeasure amount asFloat printPaddedWith: $0 to: 1.2).
	aStream space.
	aStream nextPutAll: self sign