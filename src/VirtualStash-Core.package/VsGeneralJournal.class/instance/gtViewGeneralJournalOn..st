accessing
gtViewGeneralJournalOn: aView
	<gtView>
	| result |
	result := aView columnedList
		title: 'General Journal' translated;
		priority: 5;
		items: [ self transactions flatCollect: [ :t | t journalLines ] ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result