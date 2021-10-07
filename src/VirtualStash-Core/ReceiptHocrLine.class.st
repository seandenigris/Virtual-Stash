Class {
	#name : #ReceiptHocrLine,
	#superclass : #HocrLine,
	#instVars : [
		'receipt'
	],
	#category : 'VirtualStash-Core-Receipts'
}

{ #category : #'instance creation' }
ReceiptHocrLine class >> on: aXMLElement for: aReceipt [

	^ (self on: aXMLElement)
		receipt: aReceipt;
		yourself
]

{ #category : #'as yet unclassified' }
ReceiptHocrLine >> newWordFrom: anXmlElement [

	^ ReceiptHocrWord on: anXmlElement for: self receipt
]

{ #category : #accessing }
ReceiptHocrLine >> receipt [
	^ receipt
]

{ #category : #accessing }
ReceiptHocrLine >> receipt: anObject [
	receipt := anObject
]
