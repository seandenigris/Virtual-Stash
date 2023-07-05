Class {
	#name : #VsVenmoImportRule,
	#superclass : #VsProcessorImportRule,
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #'initialization-release' }
VsVenmoImportRule >> initialize [
	super initialize.
	paymentProcessor := self ensureProcessorNamed: 'Venmo'.
]

{ #category : #testing }
VsVenmoImportRule >> primaryParser [
	^ 'VENMO' asPParser, #space asPParser plus, 'PAYMENT' asPParser and
]
