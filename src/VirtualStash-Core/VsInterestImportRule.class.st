Class {
	#name : #VsInterestImportRule,
	#superclass : #VsImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsInterestImportRule >> buildPatchOperations [
	| expenseAccount |
	expenseAccount := self accountNamed: 'Expenses:Interest'.
	
	self patch addOperationFor: self credit set: self debit accountDescription to: expenseAccount.
	self party: self credit account issuer.
	super buildPatchOperations
]

{ #category : #testing }
VsInterestImportRule >> primaryParser [

	^ self primaryParserFromOptions: #(
		'Purchase Finance Charge'
		'PURCHASE INTEREST CHARGE').
]
