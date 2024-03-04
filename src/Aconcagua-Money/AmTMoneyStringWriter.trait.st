Trait {
	#name : #AmTMoneyStringWriter,
	#instVars : [
		'writesFraction',
		'writesCommodity'
	],
	#category : #'Aconcagua-Money'
}

{ #category : #visiting }
AmTMoneyStringWriter >> shouldWriteFractionOf: aNumber [

	self writesAllFractions ifTrue: [ ^ true ].
	self writesNoFractions ifTrue: [ ^ false ].
	
	^ aNumber fractionPart ~= 0
]

{ #category : #accessing }
AmTMoneyStringWriter >> write: aMeasure on: aStream [

	| amount fractionString integerPart |
	amount := aMeasure amount.
	
	(self shouldWriteFractionOf: amount) 
		ifTrue: [ 
			integerPart := amount floor.
			fractionString := '.', ((amount fractionPart * 100) asInteger printPaddedWith: $0 to: 2) ]
		ifFalse: [
			integerPart := amount rounded.
			fractionString := '' ].
			
	aStream << $$ << integerPart abs asStringWithCommas << fractionString.
		
	self writesCommodity ifTrue: [
		aStream
			space;
			nextPutAll: aMeasure unit sign ]
]

{ #category : #accessing }
AmTMoneyStringWriter >> writeAllFractions [
	writesFraction := 1
]

{ #category : #accessing }
AmTMoneyStringWriter >> writeNoFractions [
	writesFraction := -1
]

{ #category : #accessing }
AmTMoneyStringWriter >> writeOn: aStream [
]

{ #category : #accessing }
AmTMoneyStringWriter >> writeSmartFractions [
	writesFraction := 0
]

{ #category : #accessing }
AmTMoneyStringWriter >> writesAllFractions [
	^ writesFraction = 1
]

{ #category : #accessing }
AmTMoneyStringWriter >> writesCommodity [
	^ writesCommodity ifNil: [ false ]
]

{ #category : #accessing }
AmTMoneyStringWriter >> writesCommodity: anObject [
	writesCommodity := anObject
]

{ #category : #accessing }
AmTMoneyStringWriter >> writesNoFractions [
	^ writesFraction = -1
]

{ #category : #accessing }
AmTMoneyStringWriter >> writesSmartFractions [
	^ writesFraction = 0 or: [ writesFraction isNil ]
]
