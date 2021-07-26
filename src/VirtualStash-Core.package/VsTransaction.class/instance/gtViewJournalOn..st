accessing
gtViewJournalOn: aView
	<gtView>
	| result |
	result := aView columnedList
		title: 'Splits' translated;
		priority: 5;
		items: [ self journalLines ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result