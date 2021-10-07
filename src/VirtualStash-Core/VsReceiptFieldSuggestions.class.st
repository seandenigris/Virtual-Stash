Class {
	#name : #VsReceiptFieldSuggestions,
	#superclass : #Object,
	#instVars : [
		'suggestions',
		'bestGuess'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #'instance creation' }
VsReceiptFieldSuggestions class >> on: anOrderedCollection [

	^ self new
		suggestions: anOrderedCollection;
		yourself.
]

{ #category : #'as yet unclassified' }
VsReceiptFieldSuggestions >> bestGuess: guess [

	bestGuess := guess.
]

{ #category : #'as yet unclassified' }
VsReceiptFieldSuggestions >> suggestions: anOrderedCollection [ 

	suggestions := anOrderedCollection.
]
