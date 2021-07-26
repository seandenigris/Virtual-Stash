initialization
initializeWidgets

	self instantiateModels: #(
		previousMonthButton ButtonModel
		nextMonthButton ButtonModel
		month DropListModel
		year DropListModel
		list	MultiColumnListModel "ListComposableModel"
		summary MultiColumnListModel
		addButton ButtonModel).
	
	self
		initializeDateChooser;
		initializeList;
		initializeSummary;
		initializeAddButton.