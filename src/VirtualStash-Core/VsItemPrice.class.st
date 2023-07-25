Class {
	#name : #VsItemPrice,
	#superclass : #Object,
	#instVars : [
		'name',
		'quantity',
		'unitPrice',
		'date'
	],
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsItemPrice >> date [
	^ date
]

{ #category : #accessing }
VsItemPrice >> date: anObject [
	date := anObject
]

{ #category : #accessing }
VsItemPrice >> name [
	^ name
]

{ #category : #accessing }
VsItemPrice >> name: anObject [
	name := anObject
]

{ #category : #accessing }
VsItemPrice >> quantity [
	^ quantity
]

{ #category : #accessing }
VsItemPrice >> quantity: anObject [
	quantity := anObject
]

{ #category : #accessing }
VsItemPrice >> total [

	^ self quantity * self unitPrice
]

{ #category : #accessing }
VsItemPrice >> unitPrice [
	^ unitPrice
]

{ #category : #accessing }
VsItemPrice >> unitPrice: anObject [
	unitPrice := anObject
]
