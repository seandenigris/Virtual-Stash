Class {
	#name : #ReceiptHocrWord,
	#superclass : #HocrWord,
	#instVars : [
		'receipt'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #'instance creation' }
ReceiptHocrWord class >> on: aXMLElement for: aReceipt [

	^ (self on: aXMLElement)
		receipt: aReceipt;
		yourself
]

{ #category : #'as yet unclassified' }
ReceiptHocrWord >> beDate [

	| separator number dateRule parseResult |
	separator := $/ asPParser.
	number := #digit asPParser star flatten.
	dateRule := (number, separator, number, separator, number) flatten.
	parseResult := dateRule parse: self string.
	self receipt date: parseResult asDate
]

{ #category : #'as yet unclassified' }
ReceiptHocrWord >> bePaymentType [

	| paymentType |
	paymentType := VsPaymentMethod all detect: [ :e | e isPaymentTypeFor: self string ].
	self receipt paymentMethod: paymentType
]

{ #category : #'as yet unclassified' }
ReceiptHocrWord >> beTotalAmount [

	| number dollars cents amountRule parseResult |
	dollars := number := #digit asPParser plus flatten.
	cents := $. asPParser, number.
	amountRule := $$ asPParser optional, (dollars, cents optional) flatten end ==> #second.
	parseResult := amountRule parse: self string.
	self receipt amount: parseResult asNumber
]

{ #category : #testing }
ReceiptHocrWord >> isValidPaymentType [

	^ VsPaymentMethod all anySatisfy: [ :e | e isPaymentTypeFor: self string ]
]

{ #category : #accessing }
ReceiptHocrWord >> receipt [
	^ receipt
]

{ #category : #accessing }
ReceiptHocrWord >> receipt: anObject [
	receipt := anObject
]
