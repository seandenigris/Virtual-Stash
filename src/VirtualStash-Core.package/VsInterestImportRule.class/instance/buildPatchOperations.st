accessing
buildPatchOperations
	| expenseAccount |
	expenseAccount := self accountNamed: 'Expenses:Interest'.
	
	self patch addOperationFor: self credit set: self debit accountDescription to: expenseAccount.
	self party: self credit account issuer.
	super buildPatchOperations