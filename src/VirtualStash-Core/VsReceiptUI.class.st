"
VsReceiptUI new
	receipt: VsReceiptFile uniqueInstance receipts atRandom;
	openWithSpec.
"
Class {
	#name : #VsReceiptUI,
	#superclass : #SpPresenter,
	#instVars : [
		'ocr',
		'detail',
		'image',
		'receipt'
	],
	#category : #'VirtualStash-Core-Receipts-UI'
}

{ #category : #'instance creation' }
VsReceiptUI class >> open [

	^ self new openWithSpec.
]

{ #category : #accessing }
VsReceiptUI class >> spec [
	<spec: #default>

	^ SpecLayout composed
			newRow: [ :spec | spec add: #image; add: #detail; add: #ocr ];
			yourself.
]

{ #category : #specs }
VsReceiptUI class >> title [

	^ ''.
]

{ #category : #'as yet unclassified' }
VsReceiptUI >> detail [

	^ detail.
]

{ #category : #'as yet unclassified' }
VsReceiptUI >> image [
	^ image
]

{ #category : #'as yet unclassified' }
VsReceiptUI >> initializePresenter [

	ocr list whenSelectedItemChanged: [ :line | | imageMorph |
		line ifNotNil: [ 
			imageMorph := image morph submorphs first submorphs first.
			imageMorph select: line ] ].
]

{ #category : #initialization }
VsReceiptUI >> initializeWidgets [

	image := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.

	ocr := self instantiate: HocrBrowser.
	
	detail := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.
]

{ #category : #'as yet unclassified' }
VsReceiptUI >> ocr [
	^ ocr
]

{ #category : #accessing }
VsReceiptUI >> receipt [
	^ receipt
]

{ #category : #accessing }
VsReceiptUI >> receipt: aVsReceipt [

	receipt := aVsReceipt.
	self refresh.
]

{ #category : #'as yet unclassified' }
VsReceiptUI >> refresh [

	| imageMorph detailMorph |
	imageMorph := receipt asMorph.
	image widget
		removeAllMorphs;
		addMorph: imageMorph.
	imageMorph addFlexShell
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	
	ocr receipt: receipt.
	
	detailMorph := receipt asMagritteMorph morph
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	detail morph
		removeAllMorphs;
		addMorph: detailMorph.
]
