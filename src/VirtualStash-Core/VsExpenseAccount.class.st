Class {
	#name : #VsExpenseAccount,
	#superclass : #VsAccount,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #'as yet unclassified' }
VsExpenseAccount >> normalBalance [
	^ #debit
]
