Class {
	#name : 'VsCash',
	#superclass : 'VsPaymentMethod',
	#category : 'VirtualStash-Core-Receipts',
	#package : 'VirtualStash-Core',
	#tag : 'Receipts'
}

{ #category : 'testing' }
VsCash >> isPaymentTypeFor: aString [ 

	^ aString asLowercase = 'cash'
]

{ #category : 'printing' }
VsCash >> printOn: aStream [

	aStream nextPutAll: 'Cash'.
]
