Class {
	#name : #VsPaystub,
	#superclass : #VsReceipt,
	#instVars : [
		'end'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsPaystub >> counterpartyDescription [
	
	^ (super counterpartyDescription)
			label: 'Company';
			yourself
]

{ #category : #accessing }
VsPaystub >> dateGuess [

	| candidates |
	candidates := self datesRecognized.
	candidates size = 0 ifTrue: [ ^ nil ].
	
	^ self datesRecognized detectMin: [ :e | e key boundingBox center x ].
]

{ #category : #accessing }
VsPaystub >> datesRecognized [
	^ self datesRecognizedHocr collect: #value
]

{ #category : #accessing }
VsPaystub >> datesRecognizedHocr [
	^ self hocr words 
		inject: Bag new 
		into: [ :col :word | 
			| parseResult isNewDate |
			parseResult := Date pp2Parser mmddyyyy parse: word string onError: [ nil ].
			isNewDate := parseResult isNotNil and: [ col noneSatisfy: [ :e | e value = parseResult ] ].
			isNewDate ifTrue: [ col add: word -> parseResult ].
			col ].
]

{ #category : #accessing }
VsPaystub >> end [

	^ end
]

{ #category : #accessing }
VsPaystub >> end: anObject [

	end := anObject
]

{ #category : #accessing }
VsPaystub >> endDescription [
	<magritteDescription>
	^ MADateDescription new
			accessor: #end;
			display: #mmddyyyy;
			beRequired;
			default: self guessEnd;
			shouldCacheDefault: true;
			priority: 200;
			propertyAt: #completions put: [ :doc | doc datesRecognized collect: #mmddyyyy ];
			yourself
]

{ #category : #accessing }
VsPaystub >> guessEnd [

	| candidates |
	candidates := self datesRecognized.
	candidates size = 0 ifTrue: [ ^ nil ].
	
	^ self datesRecognized detectMax: [ :e | e key boundingBox center x ].
]
