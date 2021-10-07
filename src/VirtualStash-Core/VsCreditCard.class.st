Class {
	#name : #VsCreditCard,
	#superclass : #VsPaymentMethod,
	#instVars : [
		'name',
		'lastFour'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #'as yet unclassified' }
VsCreditCard class >> named: aString [ 

	^ self new
			name: aString;
			yourself.
]

{ #category : #accessing }
VsCreditCard >> ending: anInteger [ 

	lastFour := anInteger.
]

{ #category : #testing }
VsCreditCard >> isPaymentTypeFor: aString [ 

	^ aString endsWith: self lastFour asString
]

{ #category : #accessing }
VsCreditCard >> lastFour [

	^ lastFour
]

{ #category : #accessing }
VsCreditCard >> name [

	^ name.
]

{ #category : #private }
VsCreditCard >> name: aString [ 

	name := aString.
]

{ #category : #printing }
VsCreditCard >> printOn: aStream [

	aStream
		nextPutAll: name.
]
