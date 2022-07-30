Class {
	#name : #VsPaystub,
	#superclass : #VsReceipt,
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsPaystub >> possibleDates [
	| dateWords rightmostDate |
	dateWords := self hocr words 
		inject: Bag new 
		into: [ :col :word | 
			| parseResult isNewDate |
			parseResult := PP2DateParser new mmddyyyy parse: word string onError: [ nil ].
			isNewDate := parseResult isNotNil and: [ col noneSatisfy: [ :e | e value = parseResult ] ].
			isNewDate ifTrue: [ col add: word -> parseResult ].
			col ].
	
	dateWords ifEmpty: [ ^ #() ].
	
	rightmostDate := dateWords detectMax: [ :e | e key boundingBox center x ].
	^ { rightmostDate value }
]
