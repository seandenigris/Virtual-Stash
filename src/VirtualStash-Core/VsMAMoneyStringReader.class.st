Class {
	#name : #VsMAMoneyStringReader,
	#superclass : #MAStringReader,
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsMAMoneyStringReader >> visitMoneyDescription: anObject [
	| money |
	money := AmDollar readFrom: self stream upToEnd trimmed.
	self object: money
]
