Trait {
	#name : #VsTAmexSplit,
	#category : #'VirtualStash-Core-Importing-Amex'
}

{ #category : #accessing }
VsTAmexSplit >> amountDescription [
	
	^ (super amountDescription)
		accessor: #amexAmount;
		yourself
]
