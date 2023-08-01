Class {
	#name : #VsItem,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #accessing }
VsItem >> displayStringOn: aStream [

	self name ifNotNil: [ :n | aStream << n ]
]

{ #category : #accessing }
VsItem >> name [
	^ name
]

{ #category : #accessing }
VsItem >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
VsItem >> price [
	
	^ VsPriceList uniqueInstance priceFor: self.
]

{ #category : #accessing }
VsItem >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #accessing }
VsItem >> unknownPrice [

	^ VsUnknownPrice new
		item: self;
		quantity: 1;
		yourself.
]
