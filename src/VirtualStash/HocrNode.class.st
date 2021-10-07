Class {
	#name : #HocrNode,
	#superclass : #Object,
	#instVars : [
		'xmlElement'
	],
	#category : 'VirtualStash-Tesseract'
}

{ #category : #'instance creation' }
HocrNode class >> on: aXMLElement [ 

	^ self new
		xmlElement: aXMLElement;
		yourself.
]

{ #category : #accessing }
HocrNode >> boundingBox [

	| propertiesString tokens |
	propertiesString := xmlElement attributeAt: 'title'.
	tokens := Character space split: propertiesString.
	tokens first = 'bbox' ifFalse: [ self error: 'missing bbox tag' ].
	^ Rectangle left: tokens second asNumber right: tokens fourth asNumber top: tokens third asNumber bottom: tokens fifth asNumber. 
]

{ #category : #'as yet unclassified' }
HocrNode >> printOn: aStream [

	aStream
		nextPutAll: self string;
		nextPutAll: '(hocr)'.
]

{ #category : #accessing }
HocrNode >> string [

	^ xmlElement contentString.
]

{ #category : #private }
HocrNode >> xmlElement: aXMLElement [ 

	xmlElement := aXMLElement.
]
