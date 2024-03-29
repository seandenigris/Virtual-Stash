Class {
	#name : #VsAccountBenefit,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'name'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsAccountBenefit >> name [

	^ name
]

{ #category : #accessing }
VsAccountBenefit >> name: anObject [

	name := anObject
]

{ #category : #accessing }
VsAccountBenefit >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' (benefit)'
]
