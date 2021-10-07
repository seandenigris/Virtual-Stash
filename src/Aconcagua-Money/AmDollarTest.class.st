Class {
	#name : #AmDollarTest,
	#superclass : #TestCase,
	#category : 'Aconcagua-Money-Tests'
}

{ #category : #accessing }
AmDollarTest >> testDollarCreatingFractionalFromNumber [
	^ 1.15 dollars
]

{ #category : #accessing }
AmDollarTest >> testDollarCreatingFromNumber [
	^ 1 dollar
]

{ #category : #accessing }
AmDollarTest >> testDollarCreatingFromString [
	AmDollar fromString: '$1.00'.
	self should: [ AmDollar fromString: '$1.0a' ] raise: Error
]

{ #category : #accessing }
AmDollarTest >> testDollarCreatingMultipleFromNumber [
	^ 10 dollars
]

{ #category : #accessing }
AmDollarTest >> testDollarParsing [
	#('$1' '$1.0' '$1.00')
		do: [ :in | self assert: (AmDollar parser matches: in) ].
	#('$a' '$1.' '$.00' '1')
		do: [ :in | self deny: (AmDollar parser matches: in) ]
]

{ #category : #accessing }
AmDollarTest >> testDollarPrinting [
	self
		assert: self testDollarCreatingFromNumber printString
		equals: '$1.00 USD'.
	self
		assert: self testDollarCreatingMultipleFromNumber printString
		equals: '$10.00 USD'
]
