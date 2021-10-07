Class {
	#name : #VsReceiptDouble,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : 'VirtualStash-Core-Receipts-Specification'
}

{ #category : #'as yet unclassified' }
VsReceiptDouble >> addString: aString [ 
	string := aString
]

{ #category : #'as yet unclassified' }
VsReceiptDouble >> includesSubstring: aString [ 
	^ string asLowercase includesSubstring: aString asLowercase
]
