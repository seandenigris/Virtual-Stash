Class {
	#name : #AmCent,
	#superclass : #BaseUnit,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Aconcagua-Money'
}

{ #category : #accessing }
AmCent class >> new [
	^ super new
		initializeNameForOne: 'cent'
		nameForMany: 'cents'
		sign: 'c USD'
]

{ #category : #comparing }
AmCent >> = rhs [
	^ self class = rhs class
]

{ #category : #comparing }
AmCent >> hash [
	^ self class hash
]

{ #category : #printing }
AmCent >> print: aMeasure on: aStream [ 

	aMeasure amount printOn: aStream.
	aStream nextPutAll: self sign
]
