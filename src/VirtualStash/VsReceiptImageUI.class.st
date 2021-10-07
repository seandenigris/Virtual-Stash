Class {
	#name : #VsReceiptImageUI,
	#superclass : #ImageMorph,
	#instVars : [
		'receipt',
		'selection'
	],
	#category : 'VirtualStash-Receipts-UI'
}

{ #category : #'as yet unclassified' }
VsReceiptImageUI class >> on: aVSReceipt [

	^ self new
		receipt: aVSReceipt;
		yourself.
]

{ #category : #private }
VsReceiptImageUI >> addOcrBoxes [

	receipt hocr lines do: [ :e | | boxMorph |
		boxMorph := BorderedMorph new
			color: Color transparent;
			bounds: e boundingBox;
			yourself.
		boxMorph topLeft: self topLeft + e boundingBox topLeft.
		self addMorph: boxMorph ]
]

{ #category : #private }
VsReceiptImageUI >> receipt: aVsReceipt [ 

	receipt := aVsReceipt.
	self image: aVsReceipt form.
	self addOcrBoxes.

]

{ #category : #'as yet unclassified' }
VsReceiptImageUI >> select: aHocrLine [ 

	| target |
	target := self submorphThat: [ :e | e containsPoint: self topLeft + aHocrLine boundingBox center ] ifNone: [ self error: 'no hocr line at point' ].
	selection ifNotNil: [ selection borderColor: Color black ].
	selection := target.
	target borderColor: Color pink.
]
