Class {
	#name : #VsTaxDocument,
	#superclass : #VsDocument,
	#instVars : [
		'year'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsTaxDocument >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		space;
		print: year
]

{ #category : #accessing }
VsTaxDocument >> wantsHOCR [
	^ false
]

{ #category : #accessing }
VsTaxDocument >> year [

	^ year
]

{ #category : #accessing }
VsTaxDocument >> year: anObject [

	year := anObject
]

{ #category : #accessing }
VsTaxDocument >> yearDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #year;
		priority: 100;
		beRequired;
		propertyAt: #whitelist put: '1234567890';
		yourself
]
