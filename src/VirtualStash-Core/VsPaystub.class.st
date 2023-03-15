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

	^ self 
		cache: #amount
		guess: [ 
			self hocr lines 
				detect: [ :e | e words size = 3 and: [ e words first string = 'DIRECT' and: [ e words second string = 'DEP' ] ] ]
				ifFound: [ :line | 
					| trimmed |
					trimmed := line words third string select: [ :c | c isDigit or: [ c = $. ] ].
					trimmed vsAsUSD ]
				ifNone: [ nil ] ]
]

{ #category : #accessing }
VsPaystub >> counterpartyDescription [
	
	^ (super counterpartyDescription)
			label: 'Company';
			yourself
]

{ #category : #accessing }
VsPaystub >> dateGuess [

	^ self 
		cache: #date
		guess: [ 
			| candidates |
			candidates := self datesRecognizedHocr.
			candidates size = 0
				ifFalse: [ candidates detectMin: [ :e | e key boundingBox center x ] ]
				ifTrue: [ nil ] ].
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

	^ self 
		cache: #end
		guess: [ 
			| candidates |
			candidates := self datesRecognizedHocr.
			candidates size = 0
				ifFalse: [ candidates detectMax: [ :e | e key boundingBox center x ] ]
				ifTrue: [ nil ] ].
]
