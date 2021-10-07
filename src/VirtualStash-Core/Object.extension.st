Extension { #name : #Object }

{ #category : #'*VirtualStash-Core' }
Object >> maToString: aSymbol [
	| description |
	description := self perform: aSymbol.
	^ description toString: (description accessor read: self)
]
