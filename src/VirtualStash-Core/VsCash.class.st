Class {
	#name : #VsCash,
	#superclass : #VsPaymentMethod,
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #testing }
VsCash >> isPaymentTypeFor: aString [ 

	^ aString asLowercase = 'cash'
]

{ #category : #printing }
VsCash >> printOn: aStream [

	aStream nextPutAll: 'Cash'.
]
