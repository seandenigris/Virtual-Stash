Class {
	#name : #VsCSVImporterField,
	#superclass : #Object,
	#instVars : [
		'csvFieldName',
		'group',
		'descriptionName'
	],
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsCSVImporterField >> csvFieldName [

	^ csvFieldName
]

{ #category : #accessing }
VsCSVImporterField >> csvFieldName: anObject [

	csvFieldName := anObject
]

{ #category : #accessing }
VsCSVImporterField >> descriptionName [

	^ descriptionName
]

{ #category : #accessing }
VsCSVImporterField >> descriptionName: anObject [

	descriptionName := anObject
]

{ #category : #accessing }
VsCSVImporterField >> group [

	^ group
]

{ #category : #accessing }
VsCSVImporterField >> group: anObject [

	group := anObject
]

{ #category : #writing }
VsCSVImporterField >> write: aString to: anObject [
	
	| elementDescription value |
	aString ifNil: [ ^ self ].
		
	elementDescription := anObject magritteDescription 
		detect: [ :e | e name = self descriptionName ]
		ifNone: [ 
			self 
				write: aString 
				toPropertyOf: anObject.
				^ self ].
			
	value := elementDescription csvReader value: aString.
	elementDescription write: value to: anObject
]

{ #category : #private }
VsCSVImporterField >> write: aString toPropertyOf: anObject [
	anObject 
		propertyAt: self descriptionName 
		put: aString
]
