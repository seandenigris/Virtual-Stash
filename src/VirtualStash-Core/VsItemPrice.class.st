Class {
	#name : #VsItemPrice,
	#superclass : #VsPrice,
	#instVars : [
		'item',
		'quantity',
		'unitPrice',
		'date'
	],
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #accessing }
VsItemPrice class >> named: aString [

	| item |
	item := VsItem new name: aString; yourself.

	^ self new
		item: item;
		yourself
]

{ #category : #accessing }
VsItemPrice >> = rhs [

	self item = rhs item ifFalse: [ ^ false ].
	self quantity = rhs quantity ifFalse: [ ^ false ].
	self unitPrice = rhs unitPrice ifFalse: [ ^ false ].
	self date = rhs date ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
VsItemPrice >> date [
	^ date
]

{ #category : #accessing }
VsItemPrice >> date: anObject [
	date := anObject
]

{ #category : #accessing }
VsItemPrice >> displayStringOn: aStream [

	aStream display: self total
]

{ #category : #accessing }
VsItemPrice >> hash [

	^ ((self item hash bitXor: self quantity hash) bitXor: self unitPrice hash) bitXor: self date hash
]

{ #category : #accessing }
VsItemPrice >> item [
	^ item
]

{ #category : #accessing }
VsItemPrice >> item: anObject [
	item := anObject
]

{ #category : #accessing }
VsItemPrice >> itemDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #item;
		priority: 300;
		classes: VsItem withAllSubclasses;
		referenceDisplay: #displayString;
		yourself
]

{ #category : #accessing }
VsItemPrice >> name [
	^ self item ifNotNil: #name
]

{ #category : #accessing }
VsItemPrice >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #accessing }
VsItemPrice >> quantity [
	^ quantity ifNil: [ 1 ]
]

{ #category : #accessing }
VsItemPrice >> quantity: anObject [
	quantity := anObject
]

{ #category : #accessing }
VsItemPrice >> quantityDescription [
	<magritteDescription>
	
	^ MANumberDescription new
		accessor: #quantity;
		priority: 200;
		yourself
]

{ #category : #accessing }
VsItemPrice >> total [
	self quantity ifNil: [ ^ nil ].
	self unitPrice ifNil: [ ^ nil ].

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

{ #category : #accessing }
VsItemPrice >> unitPriceDescription [
	<magritteDescription>
	
	^ MAMoneyDescription new
		accessor: #unitPrice;
		priority: 400;
		beRequired;
		stringReader: VsMAMoneyStringReader;
		yourself
]
