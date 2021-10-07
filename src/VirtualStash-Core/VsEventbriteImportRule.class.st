Class {
	#name : #VsEventbriteImportRule,
	#superclass : #VsProcessorImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #'initialization-release' }
VsEventbriteImportRule >> initialize [
	super initialize.
	paymentProcessor := self addressBook ensureOrganizationNamed: 'Eventbrite'.
	memo := '' "so I don't try to pull one from the parse result (which signals an error)"
]

{ #category : #testing }
VsEventbriteImportRule >> primaryParser [
	^ 'Eventbrite' asPParser
]
