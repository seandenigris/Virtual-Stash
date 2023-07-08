Class {
	#name : #VsQuickPayImportRule,
	#superclass : #VsProcessorImportRule,
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #'initialization-release' }
VsQuickPayImportRule >> initialize [
	super initialize.
	paymentProcessor := self ensureProcessorNamed: 'Chase'.
	memo := 'Quick Pay'
]

{ #category : #testing }
VsQuickPayImportRule >> primaryParser [
	^ 'QuickPay with Zelle payment to D' asPParser
]
