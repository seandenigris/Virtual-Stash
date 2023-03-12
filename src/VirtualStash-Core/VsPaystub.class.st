Class {
	#name : #VsPaystub,
	#superclass : #VsReceipt,
	#instVars : [
		'end'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsPaystub >> amountGuess [

	| candidates maxX maxY relativeX relativeY bottomRightHocr |
	candidates := self amountsRecognizedHocr.
	candidates size = 0 ifTrue: [ ^ nil ].
	
	"Amount on bottom right"
	maxX := candidates asOrderedCollection max: [ :e | e key boundingBox center x ].
	maxY := candidates asOrderedCollection max: [ :e | e key boundingBox center y ].
	bottomRightHocr := candidates detectMax: [ :e | 
		relativeX := e key boundingBox center x / maxX.
		relativeY := e key boundingBox center y / maxY * maxX.
		relativeX + relativeY ].
	^ bottomRightHocr value
]

{ #category : #accessing }
VsPaystub >> amountsRecognizedHocr [
	^ self hocr words 
		inject: Bag new 
		into: [ :col :word | 
			| parseResult isNewAmt |
			parseResult := PP2MoneyParser parse: word string onError: [ nil ].
			isNewAmt := parseResult isNotNil and: [ col noneSatisfy: [ :e | e value = parseResult ] ].
			isNewAmt ifTrue: [ col add: word -> parseResult ].
			col ].
]

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
	
	^ self datesRecognizedHocr detectMin: [ :e | e key boundingBox center x ].
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
			default: self endGuess;
			shouldCacheDefault: true;
			priority: 200;
			propertyAt: #completions put: [ :doc | doc datesRecognized collect: #mmddyyyy ];
			yourself
]

{ #category : #accessing }
VsPaystub >> endGuess [

	| candidates |
	candidates := self datesRecognized.
	candidates size = 0 ifTrue: [ ^ nil ].
	
	^ self datesRecognizedHocr detectMax: [ :e | e key boundingBox center x ].
]
