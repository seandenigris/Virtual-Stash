Class {
	#name : #VsItemPrice,
	#superclass : #VsPrice,
	#instVars : [
		'item',
		'unitPrice',
		'date',
		'isPrivate'
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
	self unitPrice = rhs unitPrice ifFalse: [ ^ false ].
	self date = rhs date ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
VsItemPrice >> bePrivate [
	^ self isPrivate: true
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
VsItemPrice >> hash [

	^ ((self item hash bitXor: self quantity hash) bitXor: self unitPrice hash) bitXor: self date hash
]

{ #category : #accessing }
VsItemPrice >> isPrivate [
	^ isPrivate ifNil: [ false ]
]

{ #category : #accessing }
VsItemPrice >> isPrivate: aBoolean [
	"aBoolean - should be true if the priced item is not generally useful or interesting, except as a component of a particular package. For example, a fee that only applies to one particular product"
	isPrivate := aBoolean
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
VsItemPrice >> total [
	self unitPrice ifNil: [ ^ nil ].

	^ self unitPrice
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
	
	^ MAMoneyDescription vsNew
		accessor: #unitPrice;
		priority: 400;
		beRequired;
		yourself
]
