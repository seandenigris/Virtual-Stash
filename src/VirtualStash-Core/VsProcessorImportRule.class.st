Class {
	#name : #VsProcessorImportRule,
	#superclass : #VsImportRule,
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #testing }
VsProcessorImportRule class >> isAbstract [
	^ self = VsProcessorImportRule
]

{ #category : #accessing }
VsProcessorImportRule >> buildPatchOperations [
	self
		patchSet: #processorDescription to: self paymentProcessor;
		patchSet: #counterpartyDescription to: nil;
		patchMemoAppend: self memo.
]

{ #category : #accessing }
VsProcessorImportRule >> ensureProcessorNamed: aString [

	paymentProcessor := self addressBook ensureOrganizationNamed: 'Venmo'.
	^ VsBooks paymentProcessors add: paymentProcessor
]
