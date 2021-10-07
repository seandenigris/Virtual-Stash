"
I am an asset account per <https://www.investopedia.com/terms/a/accountsreceivable.asp>.

[Per GnuCash](https://www.gnucash.org/docs/v4/C/gnucash-guide/chapter_accts.html), this is typically a business use only account in which you place outstanding debts owed to you. It is considered an asset because you should be able to count on these funds arriving. Transactions involving an Accounts Receivable account should not be added, changed or deleted in any way other than by using:
- post/unpost bill/invoice/voucher, or 
- process payment

"
Class {
	#name : #VsReceivableAccount,
	#superclass : #VsAssetAccount,
	#category : 'VirtualStash-Core-Bookkeeping'
}
