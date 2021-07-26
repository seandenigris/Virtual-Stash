initialization
initializeWidgets

	self instantiateModels: #(
		list	MultiColumnListModel "ListComposableModel"
		addButton ButtonModel).
	
	list
		items: VsPre2013Books uniqueInstance expenses;
		displayBlock: [ :e | 
			{ 
				e date asString.
				e account.
				e description.
				e amount asString } ].
	
	addButton
		label: 'Add expense';
		action: [ self addExpense ].