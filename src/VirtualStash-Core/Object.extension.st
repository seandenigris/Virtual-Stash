Extension { #name : #Object }

{ #category : #'*VirtualStash-Core' }
Object >> maToString: aDescription [
	^ aDescription toString: (aDescription accessor read: self)
]
