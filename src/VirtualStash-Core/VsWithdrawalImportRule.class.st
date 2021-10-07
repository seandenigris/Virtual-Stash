Class {
	#name : #VsWithdrawalImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsWithdrawalImportRule class >> example [
	"<gtExample>"
	self flag: 'need a way to stub addressbook with user/cash account'.
	^ self
		given: 'WITHDRAWAL'
		appliedTo: [ ]
		then: [ :r :t | self assert: t counterparty isNil ]
]

{ #category : #accessing }
VsWithdrawalImportRule >> buildPatchOperations [
	self patchSet: #counterpartyDescription to: nil.
	self patch addOperationFor: self debit set: self debit accountDescription to: self user vsCashAccount.
]

{ #category : #testing }
VsWithdrawalImportRule >> primaryParser [
	^ self primaryParserFromOptions: #(
		'WITHDRAWAL' ).
]
