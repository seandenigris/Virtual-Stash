Trait {
	#name : 'AmTMoneyStringWriter',
	#instVars : [
		'writesFraction',
		'writesCommodity'
	],
	#category : 'VirtualStash-Core-Support',
	#package : 'VirtualStash-Core',
	#tag : 'Support'
}

{ #category : 'visiting' }
AmTMoneyStringWriter >> shouldWriteFractionOf: aNumber [

	self writesAllFractions ifTrue: [ ^ true ].
	self writesNoFractions ifTrue: [ ^ false ].
	
	^ aNumber fractionPart ~= 0
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> write: aQuantity on: aStream [

	| amount fractionString integerPart |
	amount := aQuantity numericalValue.
	
	(self shouldWriteFractionOf: amount) 
		ifTrue: [ 
			integerPart := amount abs floor.
			fractionString := '.', ((amount abs fractionPart * 100) asInteger abs printPaddedWith: $0 to: 2) ]
		ifFalse: [
			integerPart := amount abs rounded.
			fractionString := '' ].
	
	amount < 0 ifTrue: [ aStream << $- ].
	
	aStream << $$ << integerPart abs asStringWithCommas << fractionString.
		
	self writesCommodity ifTrue: [
		aStream
			space;
			nextPutAll: aQuantity unit sign ]
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writeAllFractions [
	writesFraction := 1
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writeNoFractions [
	writesFraction := -1
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writeSmartFractions [
	writesFraction := 0
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writesAllFractions [
	^ writesFraction = 1
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writesCommodity [
	^ writesCommodity ifNil: [ false ]
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writesCommodity: anObject [
	writesCommodity := anObject
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writesNoFractions [
	^ writesFraction = -1
]

{ #category : 'accessing' }
AmTMoneyStringWriter >> writesSmartFractions [
	^ writesFraction = 0 or: [ writesFraction isNil ]
]
