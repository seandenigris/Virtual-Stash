Extension { #name : #ByteString }

{ #category : #'*Aconcagua-Money' }
ByteString >> cent [

	^ self cents
]

{ #category : #'*Aconcagua-Money' }
ByteString >> cents [

	| amt |
	amt := ScaledDecimal readFrom: (self copyWithout: $,).
	^ Measure amount: amt unit: AmCent new
]

{ #category : #'*Aconcagua-Money' }
ByteString >> dollar [

	^ self dollars
]

{ #category : #'*Aconcagua-Money' }
ByteString >> dollars [

	| amt |
	amt := ScaledDecimal readFrom: (self copyWithout: $,).
	^ Measure amount: amt unit: AmDollar new
]
