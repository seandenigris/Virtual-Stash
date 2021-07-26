accessing
importAccountsFromGnuCash
	| accnts |
	accnts := VsAccount importAllFromGnuCash: '/Users/sean/Documents/Reference/Smalltalk/User Data/Virtual Stash/Accounts/gnu_cash_account_tree.csv' asFileReference.
	self error: 'this doesn''t handle books with existing accounts'.
	self chartOfAccounts accounts: accnts