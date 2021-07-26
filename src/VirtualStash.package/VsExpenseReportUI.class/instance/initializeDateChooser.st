initialization
initializeDateChooser

	
	| monthItems earliestExpenseYear latestExpenseYear yearRange yearItems |
	previousMonthButton
		label: '<';
		action: [ Halt now ].
	nextMonthButton
		label: '>';
		action: [ Halt now ].
	monthItems := MonthNames collect: [ :e | DropListItem named: e do: [  ] ].
	month
		items: monthItems;
		setSelectedIndex: Date today month index.
		
	earliestExpenseYear := VsBooks uniqueInstance expenses first date year.
	latestExpenseYear := VsBooks uniqueInstance expenses last date year.
	yearRange := earliestExpenseYear to: latestExpenseYear.
	yearItems := yearRange collect: [ :e | DropListItem named: e asString do: [  ] ].
	year
		items: yearItems;
		setSelectedIndex: yearItems size.