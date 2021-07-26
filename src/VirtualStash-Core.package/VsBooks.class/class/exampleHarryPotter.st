examples
exampleHarryPotter
	<gtExample>
	^ self
		given: [ VsBooks new ]
		when: [ :books | 
			books
				importAccountsFromGnuCashCSV: BaselineOfVirtualStash exampleSupportFolder / 'gnu_cash_accounts_potter.csv';
				importTransactionsFromCSV: BaselineOfVirtualStash exampleSupportFolder / 'gnu_cash_2_transactions_export.csv'  ]
		then: [ :books | books generalJournal entries should haveSize: 2 ]