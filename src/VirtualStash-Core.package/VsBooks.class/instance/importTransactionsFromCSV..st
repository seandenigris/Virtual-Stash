accessing
importTransactionsFromCSV: file
	"Example:
		self importTransactionsFromCSV_File: FileLocator virtualStashData / 'gnu_cash_personal_transactions_all-2020-11-25.csv'"
	| transactions |
	transactions := VsTransactionImporter new 
		books: self;
		importFile: file.
	self generalJournal transactions addAll: transactions