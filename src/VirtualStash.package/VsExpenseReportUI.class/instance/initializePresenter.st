initialization
initializePresenter

	month whenSelectedItemChanged: [ :e |
		| newMonth |
		newMonth := Month month: e label year: year selectedItem label asNumber.
		self showExpensesFor: newMonth ].