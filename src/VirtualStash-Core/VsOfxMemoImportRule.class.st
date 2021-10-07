Class {
	#name : #VsOfxMemoImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #testing }
VsOfxMemoImportRule >> appliesTo: aVsTransaction [
	^ VsOFX_ExtInfoParser new matches: aVsTransaction memo asString
]

{ #category : #accessing }
VsOfxMemoImportRule >> buildPatchOperations [
	| newMemo |
	newMemo := VsOFX_ExtInfoParser parse: transaction memo.
	self patchMemoAppend: newMemo.
]
