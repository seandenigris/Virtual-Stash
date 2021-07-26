accessing
importAccountsFromGnuCashCSV: file
	| accnts |
	self accounts isEmptyOrNil ifFalse: [ self error: 'this doesn''t handle books with existing accounts' ].
	accnts := VsAccount importAllFromGnuCash: file.
	accnts do: [ :e | e books: self ].
	self chartOfAccounts accounts: accnts