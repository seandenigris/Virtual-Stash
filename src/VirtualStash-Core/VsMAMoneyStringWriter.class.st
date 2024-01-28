Class {
	#name : #VsMAMoneyStringWriter,
	#superclass : #MAStringWriter,
	#traits : 'AmTMoneyStringWriter',
	#classTraits : 'AmTMoneyStringWriter classTrait',
	#category : #'VirtualStash-Core'
}

{ #category : #visiting }
VsMAMoneyStringWriter >> visitMoneyDescription: aDescription [
	self write: self object on: self stream
]
