Class {
	#name : #ReceiptHocr,
	#superclass : #Hocr,
	#instVars : [
		'receipt'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #'instance creation' }
ReceiptHocr class >> on: aString for: aReceipt [

	^ (self on: aString)
		receipt: aReceipt;
		yourself
]

{ #category : #'line construction' }
ReceiptHocr >> newLineFrom: anXmlElement [

	^ ReceiptHocrLine on: anXmlElement for: self receipt
]

{ #category : #accessing }
ReceiptHocr >> receipt [
	^ receipt
]

{ #category : #accessing }
ReceiptHocr >> receipt: anObject [
	receipt := anObject
]
