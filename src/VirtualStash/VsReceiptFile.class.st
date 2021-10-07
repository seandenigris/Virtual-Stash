"
self uniqueInstance receipts: (VsReceipt fromImagesIn: FileLocator imageDirectory parent parent / 'ScanSnap')
"
Class {
	#name : #VsReceiptFile,
	#superclass : #Object,
	#instVars : [
		'receipts'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'VirtualStash-Receipts'
}

{ #category : #persistence }
VsReceiptFile class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #accessing }
VsReceiptFile class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #private }
VsReceiptFile >> import [

	VsReceiptBrowser open.
]

{ #category : #accessing }
VsReceiptFile >> receipts [

	^ receipts.
]

{ #category : #private }
VsReceiptFile >> receipts: aCollection [ 

	receipts := aCollection.
]
