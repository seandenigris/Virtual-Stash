"
Use this account to track the money you have on hand, in your wallet, in your piggy bank, under your mattress, or wherever you choose to keep it handy. This is the most liquid, or easily traded, type of asset. ([per GnuCash](https://www.gnucash.org/docs/v4/C/gnucash-guide/chapter_accts.html))

"
Class {
	#name : #VsCashAccount,
	#superclass : #VsAssetAccount,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #testing }
VsCashAccount >> isPaymentTypeFor: aString [ 

	^ aString asLowercase = 'cash'
]
