Class {
	#name : #VsDepositImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsDepositImportRule class >> example [
	<gtExample>
	
	self
		given: 'REMOTE ONLINE DEPOSIT #'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
]

{ #category : #accessing }
VsDepositImportRule >> buildPatchOperations [
	self flag: 'This will have to be done manually. No way to tell from generic deposit name'.
]

{ #category : #accessing }
VsDepositImportRule >> primaryParser [
	^ 'REMOTE ONLINE DEPOSIT #' asPParser
]
