accessing
gtViewGeneralJournalOn: aView
	<gtView>
	| result |
	result := aView columnedList
		title: 'Journal' translated;
		priority: 50;
		items: [ self transactions flatCollect: [ :t | t journalLines ] ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result