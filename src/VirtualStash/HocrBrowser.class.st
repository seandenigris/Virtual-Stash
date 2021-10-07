"
HocrBrowser openOn: VsReceiptFile uniqueInstance receipts atRandom.
"
Class {
	#name : #HocrBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'list',
		'receipt'
	],
	#category : 'VirtualStash-Tesseract'
}

{ #category : #opening }
HocrBrowser class >> on: aVsReceipt [ 

	^ self new
		receipt: aVsReceipt;
		yourself.
]

{ #category : #opening }
HocrBrowser class >> openOn: aVsReceipt [ 

	| instance |
	instance := self on: aVsReceipt.
	^ instance openWithSpec.
]

{ #category : #accessing }
HocrBrowser class >> spec [
	<spec: #default>

	^ SpecLayout composed
			"newRow: [ :spec | spec" add: #list"loadButton ] height: 30";
			yourself.
]

{ #category : #specs }
HocrBrowser class >> title [

	^ ''.
]

{ #category : #initialization }
HocrBrowser >> initializeWidgets [

	self instantiateModels: #(
		list ListModel).
	
	list displayBlock: [ :e | e string ].	
	"e.g. loadButton
		label: 'Load';
		action: [ self project load ];
		enabled: false."
]

{ #category : #initialization }
HocrBrowser >> list [

	^ list.
]

{ #category : #private }
HocrBrowser >> receipt [
	
	^ receipt.
]

{ #category : #private }
HocrBrowser >> receipt: aVsReceipt [ 

	receipt := aVsReceipt.
	list items: self receipt hocr lines.
]
