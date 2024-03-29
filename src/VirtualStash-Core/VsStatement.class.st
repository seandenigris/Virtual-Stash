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

{ #category : #accessing }
VsStatement >> month [
	| tokens |
	tokens := self file base splitOn: '-'.
	^ Month year: tokens first asNumber month: tokens second asNumber
]

{ #category : #accessing }
VsStatement >> wantsHOCR [
	^ false
]
