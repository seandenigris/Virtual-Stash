Class {
	#name : #VsStatement,
	#superclass : #VsDocument,
	#instVars : [
		'closingDate'
	],
	#category : #'VirtualStash-Core-Statements'
}

{ #category : #testing }
VsStatement class >> isClassFor: aFile [
	^ false
]

{ #category : #accessing }
VsStatement >> <= rhs [ 
	^ self month <= rhs month
]

{ #category : #accessing }
VsStatement >> closingDate [
	^ self maLazyInstVarUsing: self closingDateDescription
]

{ #category : #accessing }
VsStatement >> closingDate: aDate [
	closingDate := aDate
]

{ #category : #'magritte-accessing' }
VsStatement >> closingDateDescription [
	<magritteDescription>
	^ MADateDescription new
		accessor: #closingDate;
		yourself
]

{ #category : #'as yet unclassified' }
VsStatement >> displayStringOn: aStream [

	aStream
		print: self year start year;
		nextPut: $-;
		print: self month monthIndex
]

{ #category : #accessing }
VsStatement >> month [
	^ self closingDate month
]

{ #category : #'as yet unclassified' }
VsStatement >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #accessing }
VsStatement >> wantsHOCR [
	^ false
]

{ #category : #accessing }
VsStatement >> year [
	^ self closingDate asYear
]
