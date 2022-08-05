Class {
	#name : #VsCSVImporterField,
	#superclass : #Object,
	#instVars : [
		'csvFieldName',
		'reader',
		'target',
		'receiverBlock',
		'group'
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
VsCSVImporterField >> group [

	^ group
]

{ #category : #accessing }
VsCSVImporterField >> group: anObject [

	group := anObject
]

{ #category : #accessing }
VsCSVImporterField >> reader [

	^ reader
]

{ #category : #accessing }
VsCSVImporterField >> reader: anObject [

	reader := anObject
]

{ #category : #accessing }
VsCSVImporterField >> receiverBlock [

	^ receiverBlock ifNil: [ [ :obj | obj ] ]
]

{ #category : #accessing }
VsCSVImporterField >> receiverBlock: anObject [

	receiverBlock := anObject
]

{ #category : #accessing }
VsCSVImporterField >> target [

	^ target
]

{ #category : #accessing }
VsCSVImporterField >> target: anObject [

	target := anObject
]

{ #category : #private }
VsCSVImporterField >> write: aString describedBy: elemDesc withBlockWriterTo: anObject [
	| aReader value |
	aReader := self reader 
		ifNil: [ 
			elemDesc csvReader "ifNil: #yourself" ].
			Halt now.
	value := aReader value: aString.
	self target value: anObject value: value. 
]

{ #category : #writing }
VsCSVImporterField >> write: aString to: anObject [

	| elementDescription receiver |
	
	aString ifNil: [ ^ self ].
	
	receiver := self receiverBlock value: anObject.
	
	elementDescription := receiver magritteDescription 
		detect: [ :e | e name = self target ]
		ifNone: [ 
			self 
				write: aString 
				toPropertyOf: receiver.
				^ self ].
			
	self target isBlock 
		ifTrue: [
			self 
				write: aString 
				describedBy: elementDescription 
				withBlockWriterTo: receiver ]
		ifFalse: [
			self 
				write: aString 
				using: elementDescription 
				to: receiver ]
]

{ #category : #private }
VsCSVImporterField >> write: aString toPropertyOf: anObject [
	anObject 
		propertyAt: self target 
		put: aString
]

{ #category : #private }
VsCSVImporterField >> write: aString using: elemDesc to: anObject [ 
	| aReader value |
	aReader := self reader ifNil: [ elemDesc csvReader ].
	value := aReader value: aString.
	elemDesc write: value to: anObject
]
