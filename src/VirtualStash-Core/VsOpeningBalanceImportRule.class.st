Class {
	#name : 'VsOpeningBalanceImportRule',
	#superclass : 'VsImportRule',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'accessing' }
VsOpeningBalanceImportRule >> buildPatchOperations [
	self party: self user.
	self memo: transaction input string.
	super buildPatchOperations
]

{ #category : 'as yet unclassified' }
VsOpeningBalanceImportRule >> parser [
	^ self primaryParser, self separatorParser, self extraInfoParser end
]

{ #category : 'testing' }
VsOpeningBalanceImportRule >> primaryParser [
	^ 'Opening Balance' asPParser
]
