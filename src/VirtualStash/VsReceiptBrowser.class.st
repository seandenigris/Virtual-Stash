"
self open
"
Class {
	#name : #VsReceiptBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'list',
		'image',
		'ocr',
		'detail',
		'receiptModel'
	],
	#category : 'VirtualStash-Receipts-UI'
}

{ #category : #'as yet unclassified' }
VsReceiptBrowser class >> open [

	^ self new openWithSpec.
]

{ #category : #'as yet unclassified' }
VsReceiptBrowser class >> spec [
	<spec: #default>

	^ SpecLayout composed
			add: #list origin: 0@0 corner: 0.25@1;
			add: #receiptModel origin: 0.25@0 corner: 1@1;
			yourself.
]

{ #category : #protocol }
VsReceiptBrowser >> initialExtent [

	^ 400@210.
]

{ #category : #initialization }
VsReceiptBrowser >> initializePresenter [

	list whenSelectedItemChanged: [ :receipt | receiptModel ifNotNil: [ receiptModel receipt: receipt ] ].
]

{ #category : #initialization }
VsReceiptBrowser >> initializeWidgets [

	list := self instantiate: ListModel.
	list items: self receipts.

	receiptModel := self instantiate: VsReceiptUI.
]

{ #category : #accessing }
VsReceiptBrowser >> list [

	^ list.
]

{ #category : #accessing }
VsReceiptBrowser >> receiptModel [

	^ receiptModel.
]

{ #category : #accessing }
VsReceiptBrowser >> receipts [

	^ VsReceiptFile uniqueInstance receipts.
]
