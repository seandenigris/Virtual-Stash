"
self open.
"
Class {
	#name : #VsExpenseReportUI,
	#superclass : #ComposableModel,
	#instVars : [
		'addButton',
		'list',
		'month',
		'year',
		'summary',
		'nextMonthButton',
		'previousMonthButton'
	],
	#pools : [
		'ChronologyConstants'
	],
	#category : 'VirtualStash-UI'
}

{ #category : #'instance creation' }
VsExpenseReportUI class >> open [

	^ self new openWithSpec.
]

{ #category : #accessing }
VsExpenseReportUI class >> spec [
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
				newRow: [ :spec | spec "add: #previousMonthButton; add: #nextMonthButton;" add: #month; add: #year ] height: 30;
				newRow: [ :spec | spec add: #summary ];
				newRow: [ :spec | spec add: #list ];
				newRow: [ :spec | spec add: #addButton ] height: 30 ];
			yourself.
]

{ #category : #specs }
VsExpenseReportUI class >> title [

	^ 'Expenses for '.
]

{ #category : #initialization }
VsExpenseReportUI >> addButton [

	^ addButton.
]

{ #category : #callbacks }
VsExpenseReportUI >> addExpense [

	VsExpenseEditor enterExpenseInto: VsBooks uniqueInstance.
]

{ #category : #private }
VsExpenseReportUI >> expenses [

	^ VsBooks uniqueInstance expenses.
]

{ #category : #private }
VsExpenseReportUI >> expensesDuring: aMonth [ 

	^ VsBooks uniqueInstance expensesDuring: aMonth.
]

{ #category : #initialization }
VsExpenseReportUI >> initializeAddButton [

	addButton
		label: 'Add expense';
		action: [ self addExpense ].
]

{ #category : #initialization }
VsExpenseReportUI >> initializeDateChooser [

	
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
]

{ #category : #initialization }
VsExpenseReportUI >> initializeList [

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
]

{ #category : #initialization }
VsExpenseReportUI >> initializePresenter [

	month whenSelectedItemChanged: [ :e |
		| newMonth |
		newMonth := Month month: e label year: year selectedItem label asNumber.
		self showExpensesFor: newMonth ].
]

{ #category : #initialization }
VsExpenseReportUI >> initializeSummary [

	summary
		"items: VsBooks uniqueInstance expenses;"
		displayBlock: [ :e | 
			{ 
				e accountName.
				e balance printShowingDecimalPlaces: 2 } ].
]

{ #category : #initialization }
VsExpenseReportUI >> initializeWidgets [

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
]

{ #category : #accessing }
VsExpenseReportUI >> list [
	^ list
]

{ #category : #accessing }
VsExpenseReportUI >> month [
	^ month
]

{ #category : #accessing }
VsExpenseReportUI >> nextMonthButton [
	^ nextMonthButton
]

{ #category : #accessing }
VsExpenseReportUI >> previousMonthButton [
	^ previousMonthButton
]

{ #category : #private }
VsExpenseReportUI >> showExpensesFor: aMonth [

	| monthlyExpenses accounts balances balance total totalBalance closingDate |
	monthlyExpenses := self expensesDuring: aMonth.
	accounts := (monthlyExpenses collect: [ :e | e account ]) asSet asOrderedCollection.
	balances := accounts collect: [ :acc |
		balance := monthlyExpenses inject: 0 into: [ :sum :exp | 
			exp account = acc
				ifTrue: [ sum + exp amount ]
				ifFalse: [ sum ] ].
		VsAccountBalance of: acc is: balance ].
	total := balances inject: 0 into: [ :sum :e | sum + e balance ].
	closingDate := aMonth end asDate.
	totalBalance := VsAccountBalance of: 'Total (', closingDate asString, ')' is: total.
	balances add: totalBalance.
	summary items: balances.
	list items: monthlyExpenses.
]

{ #category : #accessing }
VsExpenseReportUI >> summary [
	^ summary
]

{ #category : #accessing }
VsExpenseReportUI >> year [
	^ year
]
