Class {
	#name : 'AmCentTest',
	#superclass : 'TestCase',
	#category : 'VirtualStash-Core-Support',
	#package : 'VirtualStash-Core',
	#tag : 'Support'
}

{ #category : 'accessing' }
AmCentTest >> testConverting [
	self
		assert: self testCreatingMultipleFromNumber convertToBaseUnit
		equals: 0.10 dollars
]

{ #category : 'accessing' }
AmCentTest >> testCreatingMultipleFromNumber [
	^ 10 cents
]

{ #category : 'accessing' }
AmCentTest >> testCreatingOneFromNumber [
	^ 1 cent
]

{ #category : 'accessing' }
AmCentTest >> testPrinting [
	self
		assert: self testCreatingOneFromNumber printString
		equals: '1 cent'.
	self
		assert: self testCreatingMultipleFromNumber printString
		equals: '10 cents'
]
