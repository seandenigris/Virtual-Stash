Class {
	#name : #VsReceiptImageUI,
	#superclass : #ImageMorph,
	#instVars : [
		'receipt',
		'selection'
	],
	#category : 'VirtualStash-Core-Receipts-UI'
}

{ #category : #'as yet unclassified' }
VsReceiptImageUI class >> on: aVSReceipt [

	^ self new
		receipt: aVSReceipt;
		yourself.
]

{ #category : #'event handling' }
VsReceiptImageUI >> handleMouseMove: anEvent [
	"Purpose: We want to handle events with no buttons pressed, but by default Morphic only fires #mouseMove: if a mouse a button is down"

	"Without the following line, mouse events are processed even if e.g. a window is dragged over me!"
	(anEvent hand hasSubmorphs) ifTrue: [ ^self ].
	
	^ self mouseMove: anEvent
]

{ #category : #'event handling' }
VsReceiptImageUI >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #private }
VsReceiptImageUI >> highlightWord: aHocrWord [

	| newMorph |
	newMorph := aHocrWord asMorph.
	newMorph
		topLeft: self topLeft + aHocrWord boundingBox topLeft.
	self addMorph: newMorph.
]

{ #category : #private }
VsReceiptImageUI >> isHighlightingWordAt: aPoint [ 

	^ self submorphs anySatisfy: [ :e | e bounds containsPoint: aPoint ]
]

{ #category : #'event handling' }
VsReceiptImageUI >> mouseDown: evt [

	evt yellowButtonPressed ifTrue: [ self showContextMenu ]
]

{ #category : #'event handling' }
VsReceiptImageUI >> mouseMove: anEvent [

	| hoveredWord |
	(self isHighlightingWordAt: anEvent cursorPoint) ifTrue: [ ^ self ].
	hoveredWord := receipt hocr words
		detect: [ :e | e boundingBox containsPoint: anEvent cursorPoint - self topLeft ]
		ifNone: [ ^ self ].
	self highlightWord: hoveredWord.
]

{ #category : #accessing }
VsReceiptImageUI >> receipt [
	^ receipt
]

{ #category : #private }
VsReceiptImageUI >> receipt: aVsReceipt [ 

	receipt := aVsReceipt.
	self image: aVsReceipt form.

]

{ #category : #private }
VsReceiptImageUI >> showContextMenu [

	| menu possibleVendor |
	menu := UIManager default newMenuIn: self for: self receipt.
	
	possibleVendor := self receipt possibleVendors.
	menu add: 'Make ', possibleVendor name, ' vendor' selector: #vendor: argument: possibleVendor.
	menu add: 'Enter as personal' selector: #enterAsPersonal.
	menu popUpEvent: self activeHand lastEvent in: self world.
]
