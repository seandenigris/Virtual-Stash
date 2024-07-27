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
VsPriceLine >> dateDescription [
	<magritteDescription>
	
	^ MADateDescription new
		accessor: #date;
		priority: 100;
		beReadOnly;
		yourself
]

{ #category : #accessing }
VsPriceLine >> descriptionDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		label: 'Description';
		accessor: #(price name);
		priority: 400;
		beRequired;
		yourself
]

{ #category : #accessing }
VsPriceLine >> displayStringOn: aStream [

	self quantity ifNotNil: [ :qty | 
		aStream << qty asString ].
	self price name ifNotNil: [ :n | aStream << n ].
	aStream nextPutAll: ' @ '.
	self unitPrice ifNotNil: [ :n | aStream print: n ].
	aStream 
		nextPutAll: ' = ';
		display: self total
]

{ #category : #accessing }
VsPriceLine >> hash [

	^ self price hash bitXor: self quantity hash
]

{ #category : #accessing }
VsPriceLine >> price [
	^ price ifNil: [ price := VsItemPrice new ]
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
		referenceDisplay: #total;
		classes: VsPrice allSubclasses;
		yourself
]

{ #category : #accessing }
VsPriceLine >> printOn: aStream [

	self printFromDisplayStringOn: aStream
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
VsPriceLine >> totalDescription [
	<magritteDescription>
	
	^ MAMoneyDescription vsNew
		accessor: #total;
		priority: 500;
		beReadOnly;
		yourself
]

{ #category : #accessing }
VsPriceLine >> unitPrice [

	^ self price total
]

{ #category : #accessing }
VsPriceLine >> unitPrice: aMeasure [

	^ self price unitPrice: aMeasure
]

{ #category : #accessing }
VsPriceLine >> unitPriceDescription [
	<magritteDescription>
	
	^ MAMoneyDescription vsNew
		accessor: #unitPrice;
		priority: 400;
		yourself
]
