accessing
gtSearchAccountsFor: aStep
	<gtSearch>
	^ aStep listProcessor
		title: 'Accounts';
		priority: 1;
		allCandidates: [ self accounts ];
		itemName: #displayString;
		matchSubstrings