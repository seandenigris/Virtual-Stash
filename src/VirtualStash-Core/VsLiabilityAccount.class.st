"
Liabilities is the group of things on which you owe money. Your liabilities could include a car loan, a student loan, a mortgage, your investment margin account, or anything else which you must pay back at some time. ([per GnuCash](https://www.gnucash.org/docs/v4/C/gnucash-guide/chapter_accts.html))

"
Class {
	#name : #VsLiabilityAccount,
	#superclass : #VsAccount,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #'as yet unclassified' }
VsLiabilityAccount >> normalBalance [
	^ #credit
]
