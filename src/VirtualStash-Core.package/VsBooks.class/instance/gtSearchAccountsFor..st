accessing
gtSearchAccountsFor: aStep
	<gtSearch>
	^ (self chartOfAccounts gtSearchAccountsFor: aStep)
		priority: 20;
		yourself