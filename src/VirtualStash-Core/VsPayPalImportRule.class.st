Class {
	#name : #VsPayPalImportRule,
	#superclass : #VsProcessorImportRule,
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #'initialization-release' }
VsPayPalImportRule >> initialize [
	super initialize.
	paymentProcessor := self ensureProcessorNamed: 'PayPal'
]

{ #category : #testing }
VsPayPalImportRule >> primaryParser [
	^ 'PAYPAL           INST XFER' asPParser
]
