printing
printOn: aStream
	amount ifNotNil: [ aStream print: amount ].
	account ifNotNil: [ 
			aStream
				space;
				print: account ].
	memo ifNotNil: [ 
			aStream
				space;
				nextPut: $(;
				nextPutAll: memo;
				nextPut: $) ]