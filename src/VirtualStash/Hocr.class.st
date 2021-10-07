Class {
	#name : #Hocr,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : 'VirtualStash-Tesseract'
}

{ #category : #'as yet unclassified' }
Hocr class >> on: aString [

	^ self new
		string: aString;
		yourself.
]

{ #category : #'as yet unclassified' }
Hocr class >> readFrom: aFileReference [

	^ self new
		readFrom: aFileReference;
		yourself.
]

{ #category : #protocol }
Hocr >> lines [

	| lineNodes |
	lineNodes := self xmlDocument allElementsSelect: [ :e | (e attributeAt: 'class') = 'ocr_line' ].
	^ lineNodes collect: [ :e | HocrLine on: e ].
]

{ #category : #protocol }
Hocr >> possibleDates [

	^ self words select: [ :e | e string matchesRegex: '\d\d?/\d\d?/\d\d\d?\d?' ].
]

{ #category : #private }
Hocr >> string: aWideString [ 

	string := aWideString.
]

{ #category : #protocol }
Hocr >> words [

	| wordNodes |
	wordNodes := self xmlDocument allElementsSelect: [ :e | (e attributeAt: 'class') = 'ocrx_word' ].
	^ wordNodes collect: [ :e | HocrWord on: e ].
]

{ #category : #protocol }
Hocr >> xmlDocument [

	| parser |
	parser := XMLDOMParser on: string.
	^ parser
		resolvesExternalEntities: false;
		parseDocument.
]
