magritte-accessing
chartOfAccountsDescription
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #chartOfAccounts;
		default: (VsChartOfAccounts new books: self; yourself);
		shouldCacheDefault: true;
		yourself