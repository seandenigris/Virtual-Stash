Class {
	#name : #VsPaymentMethod,
	#superclass : #Object,
	#classInstVars : [
		'wallet'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsPaymentMethod class >> all [

	^ wallet ifNil: [ wallet := OrderedCollection new ]
]

{ #category : #persistence }
VsPaymentMethod class >> restoreFrom: anObject [

	wallet := anObject.
]

{ #category : #persistence }
VsPaymentMethod class >> spData [

	^ wallet
]
