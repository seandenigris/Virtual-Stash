Class {
	#name : #VsOpeningBalanceImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsOpeningBalanceImportRule >> buildPatchOperations [
	self party: self user.
	self memo: transaction input string.
	super buildPatchOperations
]

{ #category : #testing }
VsOpeningBalanceImportRule >> primaryParser [
	^ 'Opening Balance' asPParser
]
