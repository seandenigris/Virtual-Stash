accessing
gtSearchTransactionsFor: aStep
	<gtSearch>
	^ aStep listProcessor
		title: 'Transactions';
		priority: 2;
		allCandidates: [ self transactions ];
		itemName: #displayString;
		matchSubstrings