Trait {
	#name : #VsTAmexTransaction,
	#category : #'VirtualStash-Core-Importing-Amex'
}

{ #category : #accessing }
VsTAmexTransaction >> numberDescription [
	
	^ super numberDescription
		name: #reference;
		csvReader: [ :str | str copyWithout: $' ];
		yourself
]
