Class {
	#name : #VsDocument,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
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
	^ MAMoneyDescription vsNew
		accessor: #amount;
		priority: 200;
		beRequired;
		stringWriter: VsMAMoneyStringWriter;
		propertyAt: #isHighlight put: true;
		propertyAt: #shortcut put: #a;
		propertyAt: #whitelist put: '$1234567890#.';
		propertyAt: #completions put: [ :doc | doc amountsRecognized collect: #asString ];
		initialAnswer: [ self amountGuess ];
		yourself
]

{ #category : #accessing }
VsDocument >> amountGuess [
	^ self cache: #amount guess: [ 
	
		| totalLine |
		totalLine := self resource asPlainText lines 
			detect: [ :line |
				| saysTotal hasMoney |
				saysTotal := (line includesSubstring: 'total' caseSensitive: false) and: [ (line includesSubstring: 'subtotal' caseSensitive: false) not ].
				hasMoney := VsMoneyParser new sea matches: line.
				saysTotal & hasMoney ]
			ifNone: [ nil ].
	
		totalLine
			ifNil: [ self amountsRecognized max ]
			ifNotNil: [ totalLine amountsRecognized ] ]
]

{ #category : #accessing }
VsDocument >> amountsRecognized [
	
	^ self resource 
		ifNotNil: [ :res | res asPlainText amountsRecognized ]
		ifNil: [ ^ #() ].
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

	maForm := self magritteElementBuilder
		completionControllerClass: PeGtCompletionController;
		completionStrategy: [ 
			PeGtCompletionStrategy new
				minimumPrefixLength: 0;
				yourself ];
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
VsDocument >> cache: aSymbol guess: aBlock [

	| key |
	key := (aSymbol, 'Guess') asSymbol.
	self 
		propertyAt: key
		ifPresent: [ :guess | ^ guess ].
		
	^ self propertyAt: key putRemovingNil: aBlock value
]

{ #category : #accessing }
VsDocument >> contents [

	^ self resource 
		ifNotNil: #contents
		ifNil: [ '' ].
]

{ #category : #accessing }
VsDocument >> contentsGtViewFor: aView [
	<gtView>
	
	self resource ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Contents';
		priority: 3;
		object: [ self resource ];
		view: #contentsGtViewFor:
]

{ #category : #accessing }
VsDocument >> counterpartiesGtSpotterFor: aSearch [
	
	^ aSearch list
		priority: 5;
		title: 'Recognized';
		items: [ self counterpartiesRecognized ];
		matchSubstrings;
		itemName:[ :aContact | aContact fullName ] 
]

{ #category : #'ocr-guessing' }
VsDocument >> counterpartiesRecognized [
	^ self addressBook contacts select: [ :c | c isVendorFor: self ]
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
			propertyAt: #isHighlight put: true;
			yourself
]

{ #category : #accessing }
VsDocument >> counterpartyGtSearchSource [
	| result |
	result := PeGtCollectedSearch new.
	result children 
		add: (PeGtDelegatedSearch to: self message: #counterpartiesGtSpotterFor:);
		add: self addressBook.
	^ result
]

{ #category : #'ocr-guessing' }
VsDocument >> counterpartyGuess [

	self resource vsCounterpartyGuess ifNotNil: [ :cp | ^ cp ].
	
	^ self counterpartiesRecognized atRandom.
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
VsDocument >> dateCompletions [
	
	| dateCollection |
	dateCollection := self datesRecognized ifEmpty: [ { Date today } ].
	^ dateCollection collect: #mmddyyyy
]

{ #category : #magritte }
VsDocument >> dateDescription [
	<magritteDescription>
	
	^ MADateDescription new
		accessor: #date;
		display: #mmddyyyy;
		beRequired;
		initialAnswer: [ self dateCompletions atRandom ];
		priority: 100;
		propertyAt: #isHighlight put: true;
		propertyAt: #shortcut put:#d;
		propertyAt: #completions 
			put: [ :doc | doc dateCompletions ];
		yourself
]

{ #category : #'ocr-guessing' }
VsDocument >> dateGuess [

	^ self
		cache: #date
		guess: [
			| candidates |
			candidates := self datesRecognized select: [ :d |
				d <= Date today ].
			candidates size = 0
				ifFalse: [ candidates atRandom ]
				ifTrue: [ nil ] ]
]

{ #category : #accessing }
VsDocument >> datesRecognized [
	^ self resource 
		ifNotNil: #datesRecognized
		ifNil: [ #() ].
]

{ #category : #accessing }
VsDocument >> form [
	^ self imageResource
		ifNotNil: [ :res | res asForm ]
		ifNil: [ Morph new imageForm ]
]

{ #category : #accessing }
VsDocument >> gtHocrFor: aView [
	<gtView>
	
	(self resource respondsTo: #hocr) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'hOCR';
		priority: 2;
		object: [ self resource hocr ];
		view: #gtLinesFor:
]

{ #category : #accessing }
VsDocument >> imageResource [

	^ self resource imageResource
]

{ #category : #accessing }
VsDocument >> importFile: file [
	self resource: file asRlResource import
]

{ #category : #testing }
VsDocument >> includesSubstring: aString [ 
	"Case-insensitive"

	^ self contents 
		includesSubstring: aString 
		caseSensitive: false
]

{ #category : #accessing }
VsDocument >> printFieldsOn: aStream [

	counterparty ifNotNil: [ aStream nextPutAll: self counterparty fullName ].
	amount ifNotNil: [ aStream space; print: self amount ].
	date ifNotNil: [ aStream nextPutAll: ' on '; nextPutAll: self date mmddyyyy ].
]

{ #category : #accessing }
VsDocument >> printOn: aStream [

	self printFieldsOn: aStream.
	
	aStream nextPutAll: ' ('.
	super printOn: aStream.
	aStream nextPut: $).
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
	^ false
]
