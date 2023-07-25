Class {
	#name : #VsPackagePrice,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'VirtualStash-Core'
}

{ #category : #'as yet unclassified' }
VsPackagePrice >> add: aVsItemPrice [ 
	^ self items add: aVsItemPrice
]

{ #category : #'as yet unclassified' }
VsPackagePrice >> add: anInteger of: aVsItemPrice [

	| adjustedItem |
	adjustedItem := aVsItemPrice copy
		quantity: anInteger;
		yourself.
		
	^ self items add: adjustedItem.
]

{ #category : #accessing }
VsPackagePrice >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
VsPackagePrice >> items: anObject [
	items := anObject
]

{ #category : #accessing }
VsPackagePrice >> total [

	^ self items
		inject: 0
		into: [ :sum :item |
			sum + item total ]
]
