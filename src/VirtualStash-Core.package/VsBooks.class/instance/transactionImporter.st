accessing
transactionImporter
	"Example:
		self transactionImporter
			sourceFile: FileLocator virtualStashData / 'gnu_cash_personal_transactions_all-2020-11-25.csv';
			execute"
	^ VsTransactionImporter new 
		books: self;
		targetCollection: self generalJournal transactions.