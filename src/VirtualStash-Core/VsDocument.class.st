Class {
	#name : #VsDocument,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'counterparty',
		'date',
		'resource',
		'amount'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #'as yet unclassified' }
VsDocument class >> fromFiles: files [

	^ files collect: [ :e | 
			self new
				importFile: e;
				yourself ].
]

{ #category : #'as yet unclassified' }
VsDocument class >> fromImagesIn: directory [

	| images |
	images := directory filesMatching: '*.jpg'.
	^ self fromFiles: images
]

{ #category : #'instance creation' }
VsDocument class >> fromResourceable: aResourceable [

	^ self new
		resource: aResourceable asRlResource;
		yourself

]

{ #category : #accessing }
VsDocument >> addressBook [

	^ MpAddressBook uniqueInstance
]

{ #category : #accessing }
VsDocument >> amount [
	^ amount
]

{ #category : #accessing }
VsDocument >> amount: anObject [
	amount := anObject
]

{ #category : #magritte }
VsDocument >> amountDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #amount;
		display: [ :e | '$' , e asString ];
		priority: 200;
		beRequired;
		propertyAt: #shortcut put: #a;
		propertyAt: #whitelist put: '$1234567890#.';
		propertyAt: #completionSource put: [ :doc | doc amountsRecognized collect: #asString ];
		yourself
]

{ #category : #accessing }
VsDocument >> amountsRecognized [
	^ ((PP2MoneyParser new sea ==> #second) plus parse: self ocr) asSet
]

{ #category : #accessing }
VsDocument >> asEditorElement [
	| container figure maForm aResizer |
	container := BrHorizontalPane new
		vMatchParent;
		hMatchParent.

	figure := self asElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 2.5 ];
		margin: (BlInsets all: 5).

	maForm := (self magritteDescription elementBuilderFor: self)
		addButtons;
		element.

	maForm
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c linear weight: 1 ].
		
	aResizer := BlElement new.
	aResizer background: (Color gray alpha: 0.5).
	aResizer geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	aResizer constraintsDo: [ :c |
		c ignoreByLayout.
		c vertical exact: 70.
		c horizontal exact: 4.
		c ignored vertical alignCenter.
		c ignored horizontal alignRight ].
	aResizer addEventHandler: (BlResizerRightListener new resizeTarget: figure).
	figure addChild: aResizer.

	^ container
		addChild: figure;
		addChild: maForm;
		yourself
]

{ #category : #accessing }
VsDocument >> asElement [
	^ RlHOCRElement new
		client: self;
		yourself.
]

{ #category : #accessing }
VsDocument >> counterpartiesGtSpotterFor: aStep [
	
	^ aStep listProcessor
		priority: 5;
		title: 'Recognized';
		allCandidates: [ self counterpartiesRecognized ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName:[ :aContact | aContact fullName ] 
]

{ #category : #'ocr-guessing' }
VsDocument >> counterpartiesRecognized [
	^ self addressBook contacts select: [ :c | self resource ocr includesSubstring: c fullName caseSensitive: false ]
]

{ #category : #accessing }
VsDocument >> counterparty [

	^ counterparty
]

{ #category : #accessing }
VsDocument >> counterparty: anObject [

	counterparty := anObject
]

{ #category : #magritte }
VsDocument >> counterpartyDescription [	
	<magritteDescription>
	
	^ MAToOneRelationDescription new
			accessor: #counterparty;
			label: 'Vendor';
			gtSearchSource: (MessageSend receiver: self selector: #counterpartyGtSearchSource);
			priority: 200;
			classes: MpRelatableEntity allSubclasses;
			yourself
]

{ #category : #accessing }
VsDocument >> counterpartyGtSearchSource [
	| result |
	result := MAGtCompositeSearch new.
	result children 
		add: (MAGtDelegatedSearch to: self message: #counterpartiesGtSpotterFor:);
		add: self addressBook.
	^ result
]

{ #category : #'ocr-guessing' }
VsDocument >> counterpartyGuess [
	^ self addressBook contacts select: [ :c | self resource ocr includesSubstring: c fullName caseSensitive: false ]
]

{ #category : #accessing }
VsDocument >> date [
	^ date
]

{ #category : #accessing }
VsDocument >> date: anObject [
	date := anObject
]

{ #category : #magritte }
VsDocument >> dateDescription [
	<magritteDescription>
	^ MADateDescription new
			accessor: #date;
			label: 'Date';
			display: [ :e | e monthName , ' ' , e dayOfMonth asString , ', ' , e year asString ];
			beRequired;
			default: Date today;
			priority: 100;
			propertyAt: #shortcut put:#d;
			propertyAt: #completionSource put: [ :doc | doc datesRecognized collect: #mmddyyyy ];
			yourself
]

{ #category : #'ocr-guessing' }
VsDocument >> dateGuess [

	| candidates |
	candidates := self datesRecognized.
	candidates size = 0 ifTrue: [ ^ nil ].
	^ candidates atRandom
]

{ #category : #accessing }
VsDocument >> datesRecognized [
	^ self resource datesRecognized.
]

{ #category : #accessing }
VsDocument >> form [
	^ self imageFile
		ifNotNil: [ :f | Form fromFileNamed: f fullName ]
		ifNil: [ Morph new imageForm ]
]

{ #category : #accessing }
VsDocument >> gtFigureFor: aView [
    <gtView>
    ^ aView pannable
        title: 'Editor';
        priority: 0.5;
        stencil: [ self asEditorElement ]
]

{ #category : #accessing }
VsDocument >> gtHocrFor: aView [
	<gtView>
	^ aView forward
		title: 'hOCR';
		priority: 2;
		object: [ self hocr ];
		view: #gtLinesFor:
]

{ #category : #accessing }
VsDocument >> gtOCRFor: aView [
	<gtView>
	^ aView text
		priority: 3;
		title: 'OCR';
		text: [ self ocr ]
]

{ #category : #ocr }
VsDocument >> hocr [

	^ self resource hocr
]

{ #category : #accessing }
VsDocument >> imageFile [

	^ self resource imageFile
]

{ #category : #accessing }
VsDocument >> importFile: file [
	self resource: file asRlResource import
]

{ #category : #testing }
VsDocument >> includesSubstring: aString [ 
	"Case-insensitive"

	^ self hocr lines anySatisfy: [ :line | line string asLowercase includesSubstring: aString asLowercase ]
]

{ #category : #ocr }
VsDocument >> ocr [

	^ self resource ocr.
]

{ #category : #accessing }
VsDocument >> resource [
	^ resource
]

{ #category : #accessing }
VsDocument >> resource: anObject [
	resource := anObject
]

{ #category : #accessing }
VsDocument >> rotate [
	self resource rotate
]

{ #category : #ocr }
VsDocument >> tesseractInputFile [

	^ self resource tesseractInputFile
]

{ #category : #testing }
VsDocument >> wantsHOCR [
	^ true
]
