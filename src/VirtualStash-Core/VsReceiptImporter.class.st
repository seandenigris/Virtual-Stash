Class {
	#name : #VsReceiptImporter,
	#superclass : #Object,
	#instVars : [
		'receipt',
		'patch'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #'as yet unclassified' }
VsReceiptImporter >> amount [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> apply [
	^ self patch execute
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> buildPatchOperations [
	self
		patchSet: #amountDescription to: self amount;
		patchSet: #counterpartyDescription to: self counterparty;
		patchSet: #dateDescription to: self date.
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> counterparty [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> date [

	^ self receipt resource date translateToUTC
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> emailRecipients [

	^ self receipt resource recipients
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> emailSender [

	^ self receipt resource sender
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> patch [
	^ patch 
		ifNotNil: [ patch ]
		ifNil: [ 
			patch := MAPatchMacro new.
			self buildPatchOperations.
			patch ].
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> patchGtViewFor: aView [
	<gtView>
	self patch ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Patch';
		priority: 25;
		object: [ self patch ];
		view: #elementGtViewFor:
]

{ #category : #'as yet unclassified' }
VsReceiptImporter >> patchSet: fieldSymbol to: anObject [

	self patch 
		addOperationFor: self receipt 
		set: (self receipt perform: fieldSymbol) 
		to: anObject.
]

{ #category : #accessing }
VsReceiptImporter >> receipt [
	^ receipt
]

{ #category : #accessing }
VsReceiptImporter >> receipt: anObject [
	receipt := anObject
]
