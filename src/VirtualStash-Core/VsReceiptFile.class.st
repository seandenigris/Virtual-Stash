"
self uniqueInstance receipts: (VsReceipt fromImagesIn: VsReceipt folder)
"
Class {
	#name : #VsReceiptFile,
	#superclass : #Object,
	#instVars : [
		'receipts',
		'nonReceipts',
		'oldReceipts'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #'as yet unclassified' }
VsReceiptFile class >> browser [
		| browser |
	browser := GLMTabulator new.
	browser
		column: #list;
		column: #form;
		column: #image.
	(browser transmit)
		to: #list;
		andShow: [ :a | a list display: [ :file | file receipts ] ].
	(browser transmit)
		to: #form;
		from: #list;
		andShow: [ :a | a magritte display: [ :receipt | receipt ] ].
	(browser transmit)
		to: #image;
		from: #list;
		andShow: [ :a | 
					a morph
						display: [ :receipt | receipt ] ].
	^ browser
]

{ #category : #persistence }
VsReceiptFile class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #persistence }
VsReceiptFile class >> spData [

	^ uniqueInstance
]

{ #category : #accessing }
VsReceiptFile class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #magritte }
VsReceiptFile >> asMorph [

	^ self asMagritteMorph addButtons; morph
]

{ #category : #'as yet unclassified' }
VsReceiptFile >> browse [
	self class browser openOn: self
]

{ #category : #magritte }
VsReceiptFile >> descriptionReceipts [
	<magritteDescription>
	<gtInspectorPresentationOrder: 2>
	^ MAToManyRelationDescription new
		accessor: #receipts;
		label: 'Receipts';
		classes: {VsReceipt};
		glmPresentation: #list;
		priority: 100;
		beRequired;
		yourself
]

{ #category : #private }
VsReceiptFile >> import [

	VsReceiptBrowser open.
]

{ #category : #accessing }
VsReceiptFile >> nonReceipts [

	^ nonReceipts ifNil: [ nonReceipts := OrderedCollection new ].
]

{ #category : #accessing }
VsReceiptFile >> oldReceipts [
	^ oldReceipts ifNil: [ oldReceipts := OrderedCollection new ]
]

{ #category : #accessing }
VsReceiptFile >> oldReceipts: anObject [
	oldReceipts := anObject
]

{ #category : #accessing }
VsReceiptFile >> receipts [

	^ receipts.
]

{ #category : #private }
VsReceiptFile >> receipts: aCollection [ 

	receipts := aCollection.
]
