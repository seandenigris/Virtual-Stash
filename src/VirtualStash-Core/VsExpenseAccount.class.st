Class {
	#name : 'VsExpenseAccount',
	#superclass : 'VsAccount',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'as yet unclassified' }
VsExpenseAccount >> normalBalance [
	^ #debit
]
