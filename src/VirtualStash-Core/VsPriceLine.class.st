Class {
	#name : #VsPriceLine,
	#superclass : #Object,
	#instVars : [
		'price',
		'quantity'
	],
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #accessing }
VsPriceLine class >> named: aString [

	| item |
	item := VsItem new name: aString; yourself.

	^ self new
		item: item;
		yourself
]

{ #category : #accessing }
VsPriceLine >> = rhs [

	self price = rhs price ifFalse: [ ^ false ].
	self quantity = rhs quantity ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
VsPriceLine >> date [

	^ self price date
]

{ #category : #accessing }
VsPriceLine >> hash [

	^ self price hash bitXor: self quantity hash
]

{ #category : #accessing }
VsPriceLine >> price [
	^ price
]

{ #category : #accessing }
VsPriceLine >> price: anObject [
	price := anObject
]

{ #category : #accessing }
VsPriceLine >> priceDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #price;
		priority: 400;
		beRequired;
		yourself
]

{ #category : #accessing }
VsPriceLine >> quantity [
	^ quantity ifNil: [ 1 ]
]

{ #category : #accessing }
VsPriceLine >> quantity: anObject [
	quantity := anObject
]

{ #category : #accessing }
VsPriceLine >> quantityDescription [
	<magritteDescription>
	
	^ MANumberDescription new
		accessor: #quantity;
		priority: 200;
		yourself
]

{ #category : #accessing }
VsPriceLine >> total [
	self quantity ifNil: [ ^ nil ].
	self price ifNil: [ ^ nil ].

	^ self quantity * self unitPrice
]

{ #category : #accessing }
VsPriceLine >> unitPrice [

	^ self price total
]
