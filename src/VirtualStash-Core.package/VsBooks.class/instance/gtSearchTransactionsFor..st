accessing
gtSearchTransactionsFor: aStep
	<gtSearch>
	^ (self generalJournal gtSearchTransactionsFor: aStep)
		priority: 10;
		yourself