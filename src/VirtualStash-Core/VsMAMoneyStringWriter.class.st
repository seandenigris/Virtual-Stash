Class {
	#name : #VsMAMoneyStringWriter,
	#superclass : #MAStringWriter,
	#category : #'VirtualStash-Core'
}

{ #category : #visiting }
VsMAMoneyStringWriter >> visitMoneyDescription: aDescription [

	self stream << $$ << self object amount abs "rounded" asStringWithCommas
]
