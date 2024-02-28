Class {
	#name : #VsMAMoneyStringReader,
	#superclass : #MAStringReader,
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsMAMoneyStringReader >> visitMoneyDescription: anObject [
	| money |
	money := [ AmDollar readFrom: self stream upToEnd trimmed ]
		on: Error
		do: [ :err | MAReadError signal: err messageText ].
	self object: money
]
