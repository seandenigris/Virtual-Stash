"
| receipt |
receipt := self new asMagritteMorph.
receipt
	addWindow;
	openInWorld.
"
Class {
	#name : #VsReceipt,
	#superclass : #Object,
	#instVars : [
		'imageFileName',
		'ocr',
		'hocr',
		'vendor',
		'date',
		'amount',
		'paymentType'
	],
	#category : 'VirtualStash-Receipts'
}

{ #category : #'as yet unclassified' }
VsReceipt class >> fromImagesIn: directory [

	| images |
	images := directory filesMatching: '*.jpg'.
	^ images collect: [ :e | self new imageFile: e ].
]

{ #category : #accessing }
VsReceipt >> amount [
	^ amount
]

{ #category : #accessing }
VsReceipt >> amount: anObject [
	amount := anObject
]

{ #category : #converting }
VsReceipt >> asMorph [

	^ VsReceiptImageUI on: self.
]

{ #category : #accessing }
VsReceipt >> date [
	^ date
]

{ #category : #accessing }
VsReceipt >> date: anObject [
	date := anObject
]

{ #category : #magritte }
VsReceipt >> descriptionAmount [
	<magritteDescription>
	
    ^ MANumberDescription new
        accessor: #amount;
        label: 'Amount';
		display: [ :e | '$', e asString ];
        priority: 100;
		beRequired;
        yourself
]

{ #category : #magritte }
VsReceipt >> descriptionDate [
	<magritteDescription>
	
    ^ MADateDescription new
        accessor: #date;
        label: 'Date';
		display: [ :e | e monthName, ' ', e dayOfMonth asString, ', ', e year asString ];
		beRequired;
		default: Date today;
        priority: 100;
        yourself
]

{ #category : #magritte }
VsReceipt >> descriptionPaymentType [
	<magritteDescription>
	
    ^ MASingleOptionDescription new
        accessor: #paymentType;
        label: 'Payment Type';
		options: VsPaymentType all;
		display: [ :e | e name ];
		beRequired;
        priority: 100;
        yourself
]

{ #category : #accessing }
VsReceipt >> form [

	^ Form fromFileNamed: self imageFile fullName.
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessDate [

	^ hocr possibleDates.
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessPaymentType [

	^ VsPaymentType all detect: [ :card | hocr words anySatisfy: [ :token | token string matchesRegex: '.*x+', card lastFour asString ] ].
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessTotal [

	| possibilities bestGuess suggestions rankedGuesses |
	possibilities := hocr words select: [ :e | e string matchesRegex: '\$?\d+\.\d\d' ].
	possibilities := possibilities asOrderedCollection.
	rankedGuesses := possibilities sort: [ :a :b | | aNumeric bNumeric |
		aNumeric := a string copyWithout: $$.
		bNumeric := b string copyWithout: $$.
		aNumeric asNumber > bNumeric asNumber ].
	bestGuess := rankedGuesses first.
	suggestions := VsReceiptFieldSuggestions on: possibilities.
	^ suggestions
		bestGuess: bestGuess;
		yourself.
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessVendor [

	^ hocr words detect: [ :e | e string = 'H&M' ] ifNone: [ '?' ].
]

{ #category : #ocr }
VsReceipt >> hocr [

	^ hocr ifNil: [ hocr := Tesseract hocr: self imageFile ].
]

{ #category : #accessing }
VsReceipt >> imageFile [

	^ FileLocator imageDirectory / 'ScanSnap' / self imageFileName.
]

{ #category : #private }
VsReceipt >> imageFile: aFileReference [ 

	imageFile := aFileReference.
]

{ #category : #accessing }
VsReceipt >> imageFileName [
	^ imageFileName
]

{ #category : #accessing }
VsReceipt >> imageFileName: anObject [
	imageFileName := anObject
]

{ #category : #ocr }
VsReceipt >> ocr [

	^ ocr ifNil: [ ocr := Tesseract ocr: imageFile ].
]

{ #category : #accessing }
VsReceipt >> paymentType [
	^ paymentType
]

{ #category : #accessing }
VsReceipt >> paymentType: anObject [
	paymentType := anObject
]

{ #category : #accessing }
VsReceipt >> vendor [
	^ vendor
]

{ #category : #accessing }
VsReceipt >> vendor: anObject [
	vendor := anObject
]
