Class {
	#name : #AmDollar,
	#superclass : #ProportionalDerivedUnit,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Aconcagua-Money'
}

{ #category : #accessing }
AmDollar class >> fromString: aString [
	| parser amount |
	parser := self parser.
	(parser matches: aString) ifFalse: [ self error ].
	amount := (parser subexpression: 2) asNumber.
	^ amount dollars.
]

{ #category : #accessing }
AmDollar class >> new [
	^ super new
		initializeBaseUnit: AmCent new
		conversionFactor: 100
		nameForOne: 'dollar'
		nameForMany: 'dollars'
		sign: 'USD'
]

{ #category : #accessing }
AmDollar class >> parser [
	^ RxMatcher forString: '\$(\d+(.\d+)?)'.
	"| symbol amount |
	symbol := $$ asPParser.
	amount := #digit asPParser plus, ($. asPParser, #digit asPParser, #digit asPParser) optional.
	^ (symbol, amount flatten) ==> [ :n | n second asNumber dollars ]"
]

{ #category : #comparing }
AmDollar >> = rhs [
	^ self class = rhs class
]

{ #category : #comparing }
AmDollar >> hash [
	^ self class hash
]

{ #category : #printing }
AmDollar >> printMeasure: aMeasure on: aStream [

	aStream nextPut: $$.
	aStream nextPutAll: (aMeasure amount asFloat printPaddedWith: $0 to: 1.2).
	aStream space.
	aStream nextPutAll: self sign
]
