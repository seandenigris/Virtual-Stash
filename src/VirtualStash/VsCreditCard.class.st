Class {
	#name : #VsCreditCard,
	#superclass : #VsPaymentType,
	#instVars : [
		'name',
		'lastFour'
	],
	#category : 'VirtualStash-Receipts'
}

{ #category : #'as yet unclassified' }
VsCreditCard class >> named: aString [ 

	^ self new
			name: aString;
			yourself.
]

{ #category : #'as yet unclassified' }
VsCreditCard >> ending: anInteger [ 

	lastFour := anInteger.
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

{ #category : #'as yet unclassified' }
VsCreditCard >> printOn: aStream [

	aStream
		nextPutAll: name.
]
