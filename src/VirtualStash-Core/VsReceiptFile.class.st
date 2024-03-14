Class {
	#name : #VsReceiptFile,
	#superclass : #VsBillFile,
	#instVars : [
		'oldReceipts'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #magritte }
VsReceiptFile >> asMorph [

	^ self asMagritteMorph addButtons; morph
]

{ #category : #'as yet unclassified' }
VsReceiptFile >> browse [
	self class browser openOn: self
]

{ #category : #magritte }
VsReceiptFile >> itemBaseClass [

	^ VsReceipt
]

{ #category : #magritte }
VsReceiptFile >> itemsTypeLabel [

	^ 'Receipts'
]

{ #category : #accessing }
VsReceiptFile >> maGtFormFor: aView [
	
	^ (super maGtFormFor: aView)
		priority: 105;
		yourself
]

{ #category : #accessing }
VsReceiptFile >> oldReceipts [
	^ oldReceipts ifNil: [ oldReceipts := OrderedCollection new ]
]

{ #category : #accessing }
VsReceiptFile >> oldReceipts: anObject [
	oldReceipts := anObject
]

{ #category : #accessing }
VsReceiptFile >> receipts [

	^ self items
]
