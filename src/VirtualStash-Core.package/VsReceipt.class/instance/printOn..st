printing
printOn: aStream

	vendor ifNotNil: [ aStream nextPutAll: self vendor name ].
	amount ifNotNil: [ aStream space; print: self amount ].
	date ifNotNil: [ aStream nextPutAll: ' on '; nextPutAll: self date mmddyyyy ].
	paymentMethod ifNotNil: [ aStream nextPutAll: ' with '; print: self paymentMethod ].