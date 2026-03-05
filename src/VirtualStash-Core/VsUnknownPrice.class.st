Class {
	#name : 'VsUnknownPrice',
	#superclass : 'Object',
	#instVars : [
		'item',
		'quantity'
	],
	#category : 'VirtualStash-Core-Vendors',
	#package : 'VirtualStash-Core',
	#tag : 'Vendors'
}

{ #category : 'accessing' }
VsUnknownPrice >> date [

	^ DateAndTime unixEpoch asDate
]

{ #category : 'accessing' }
VsUnknownPrice >> item [
	^ item
]

{ #category : 'accessing' }
VsUnknownPrice >> item: anObject [
	item := anObject
]

{ #category : 'accessing' }
VsUnknownPrice >> quantity [
	^ quantity
]

{ #category : 'accessing' }
VsUnknownPrice >> quantity: anObject [
	quantity := anObject
]

{ #category : 'accessing' }
VsUnknownPrice >> total [
	^ nil
]
