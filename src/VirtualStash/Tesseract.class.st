Class {
	#name : #Tesseract,
	#superclass : #Object,
	#instVars : [
		'inputFile',
		'tempFileBase',
		'tempFileExtension'
	],
	#category : 'VirtualStash-Tesseract'
}

{ #category : #'as yet unclassified' }
Tesseract class >> hocr: aFileReference [ 

	^ self new
		inputFile: aFileReference;
		hocr.
]

{ #category : #'as yet unclassified' }
Tesseract class >> ocr: aFileReference [ 

	^ self new
		inputFile: aFileReference;
		ocr.
]

{ #category : #private }
Tesseract >> evaluate: commandString [

	| p result |
	p := PipeableOSProcess waitForCommand: commandString.
	p succeeded ifFalse: [ ^ self error: 'tesseract failed with: ', p errorUpToEnd ].
	result := self tempFile readStreamDo: [ :str | str contents ].
	self tempFile delete.
	^ result.
	
]

{ #category : #private }
Tesseract >> executable [

	| homebrewLocation macPortsLocation |
	homebrewLocation := '/usr/local/bin/tesseract' asFileReference.
	homebrewLocation exists ifTrue: [ ^ homebrewLocation ].
	
	macPortsLocation := '/opt/local/bin/tesseract' asFileReference.
	macPortsLocation exists ifTrue: [ ^ macPortsLocation ].
	
	^ self error: 'Tesseract not installed!'.
]

{ #category : #protocol }
Tesseract >> hocr [

	| hocrString |
	tempFileExtension := 'html'.
	hocrString := self evaluate: self hocrCommand.
	^ Hocr on: hocrString.
]

{ #category : #private }
Tesseract >> hocrCommand [

	^ self ocrCommand, ' hocr'.
]

{ #category : #'initialize-release' }
Tesseract >> initialize [

	super initialize.
	tempFileBase := FileLocator imageDirectory / DateAndTime now asString asLegalSelector.
]

{ #category : #private }
Tesseract >> inputFile: aFileReference [ 

	inputFile := aFileReference.
]

{ #category : #protocol }
Tesseract >> ocr [

	tempFileExtension := 'txt'.
	^ self evaluate: self ocrCommand.
]

{ #category : #private }
Tesseract >> ocrCommand [

	| template |
	template := '"{1}" "{2}" "{3}"'.
	^ template format: { self executable fullName. inputFile fullName. tempFileBase fullName }.
]

{ #category : #private }
Tesseract >> tempFile [

	^ tempFileBase, tempFileExtension.
]

{ #category : #private }
Tesseract >> tempFileBase [

	^ tempFileBase.
]
