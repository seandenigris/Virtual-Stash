initialization
initializeList

	| expensesThisMonth |
	expensesThisMonth := VsBooks uniqueInstance expensesDuring: Date today month.
	list
		items: expensesThisMonth;
		displayBlock: [ :e | 
			{ 
				e date asString.
				e account.
				e description.
				e amount printShowingDecimalPlaces: 2 } ].