"
This account is used to track your cash balance that you keep in institutions such as banks, credit unions, savings and loan, or brokerage firms - wherever someone else safeguards your money. This is the second most liquid type of account, because you can easily convert it to cash on hand. ([per GnuCash](https://www.gnucash.org/docs/v4/C/gnucash-guide/chapter_accts.html))

"
Class {
	#name : #VsBankAccount,
	#superclass : #VsAssetAccount,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #testing }
VsBankAccount >> isPaymentTypeFor: aString [ 

	^ aString asLowercase = 'cash'
]
