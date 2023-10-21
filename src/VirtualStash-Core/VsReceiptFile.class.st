"
self uniqueInstance receipts: (VsReceipt fromImagesIn: VsReceipt folder)
"
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
VsReceiptFile >> itemClass [

	^ VsReceipt
]

{ #category : #magritte }
VsReceiptFile >> itemsDescription [

	^ super itemsDescription
		label: 'Receipts';
		classes: VsReceipt withAllSubclasses;
		gtSearchDelegateTo: self resourceLibrary 
			message: #resourcesSearchRecentFor: 
			transform: [ :resource | 
				| receipt |
				receipt := VsReceipt fromResourceable: resource.
				Halt now.
				self items add: receipt ];
		yourself
]

{ #category : #accessing }
VsReceiptFile >> itemsGtViewFor: aView [
	
	^ (super itemsGtViewFor: aView)
		title: 'Receipts'
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

{ #category : #accessing }
VsReceiptFile >> resourceLibrary [
	^ RlResourceLibrary uniqueInstance
]
