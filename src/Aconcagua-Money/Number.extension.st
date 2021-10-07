Extension { #name : #Number }

{ #category : #'*Aconcagua-Money' }
Number >> cent [

	^ self cents
]

{ #category : #'*Aconcagua-Money' }
Number >> cents [

	^ self * AmCent new
]

{ #category : #'*Aconcagua-Money' }
Number >> dollar [

	^ self dollars
]

{ #category : #'*Aconcagua-Money' }
Number >> dollars [

	^ AmDollar new * self
]
