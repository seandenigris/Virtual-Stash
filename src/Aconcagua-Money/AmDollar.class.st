Class {
	#name : #AmDollar,
	#superclass : #ProportionalDerivedUnit,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Aconcagua-Money'
}

{ #category : #accessing }
AmDollar class >> fromString: aString [
	| parser amountString safeAmountString |
	parser := self parser.
	(parser matches: aString) ifFalse: [ self error ].
	amountString := (parser subexpression: 2).
	safeAmountString := amountString copyWithout: $,.
	^ safeAmountString asNumber dollars.
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
	^ RxMatcher forString: '\(?\$?(-?(\d|,)+(.\d+)?\)?)( USD)?'.
	"| symbol amount |
	symbol := $$ asPParser.
	amount := #digit asPParser plus, ($. asPParser, #digit asPParser, #digit asPParser) optional.
	^ (symbol, amount flatten) ==> [ :n | n second asNumber dollars ]"
]

{ #category : #accessing }
AmDollar class >> readFrom: aStream [

	^ self fromString: aStream contents
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

	aStream 
		nextPut: $$;
		nextPutAll: aMeasure amount asStringWithCommas;
		nextPut: $.;
		nextPutAll: ((aMeasure amount abs fractionPart * 100) asInteger printPaddedWith: $0 to: 2);
		space;
		nextPutAll: self sign
]
