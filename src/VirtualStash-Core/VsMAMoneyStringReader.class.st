Class {
	#name : 'VsMAMoneyStringReader',
	#superclass : 'MAStringReader',
	#category : 'VirtualStash-Core',
	#package : 'VirtualStash-Core'
}

{ #category : 'private' }
VsMAMoneyStringReader >> moneyFromString: aString [

	| parser amountString safeAmountString |
	parser := self parser.
	(parser matches: aString) ifFalse: [ self error ].
	amountString := (parser subexpression: 2).
	safeAmountString := amountString copyWithout: $,.
	^ VsUnits
		quantity: (ScaledDecimal readFrom: safeAmountString, 's2') 
		of: #dollar.
]

{ #category : 'private' }
VsMAMoneyStringReader >> parser [
	^ RxMatcher forString: '\(?\$?(-?(\d|,)+(.\d+)?\)?)( USD)?'.
]

{ #category : 'visiting-description' }
VsMAMoneyStringReader >> visitMoneyDescription: anObject [
	| money |
	money := [ self moneyFromString: self stream upToEnd trimmed ]
		on: Error
		do: [ :err | MAReadError signal: err messageText ].
	self object: money
]
