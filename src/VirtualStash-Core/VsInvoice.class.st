Class {
	#name : #VsInvoice,
	#superclass : #Object,
	#instVars : [
		'id',
		'date',
		'vendor',
		'file'
	],
	#classVars : [
		'DB'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsInvoice class >> DB [
	^ DB ifNil: [ DB := OrderedCollection new ]
]

{ #category : #accessing }
VsInvoice class >> DB: anObject [
	DB := anObject
]

{ #category : #accessing }
VsInvoice >> date [
	^ date
]

{ #category : #accessing }
VsInvoice >> date: anObject [
	date := anObject
]

{ #category : #accessing }
VsInvoice >> id [
	^ id
]

{ #category : #accessing }
VsInvoice >> id: anObject [
	id := anObject
]

{ #category : #accessing }
VsInvoice >> vendor [
	^ vendor
]

{ #category : #accessing }
VsInvoice >> vendor: anObject [
	vendor := anObject
]
