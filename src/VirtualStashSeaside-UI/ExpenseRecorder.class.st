Class {
	#name : #ExpenseRecorder,
	#superclass : #WAComponent,
	#instVars : [
		'monthlyExpenses'
	],
	#category : 'VirtualStashSeaside-UI'
}

{ #category : #'as yet unclassified' }
ExpenseRecorder class >> description [

	^ 'Reimbursible Expenses'.
]

{ #category : #'as yet unclassified' }
ExpenseRecorder class >> initialize [

	WAAdmin register: self asApplicationAt: 'record_expense'.
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> initialize [

	super initialize.
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> model [

	^ VsBooks my expenseReportFor: 'January' of: 2008.
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> renderContentOn: html [

	self renderHeaderOn: html.
	self renderTotalsByAccountOn: html.
	self renderExpensesOn: html.
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> renderExpense: expense on: html [

"	html listItem with: expense asString."
	html tableRow: [
		html
			tableData: expense date mmddyyyy;
			tableData: expense category;
			tableData: expense description;
			tableData: expense amount ].
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> renderExpensesOn: html [

	html heading level: 4; with: 'Itemized Expenses'.
	html table: [
		html tableRow: [
			html
				tableHeading: 'Date';
				tableHeading: 'Account';
				tableHeading: 'Description';
				tableHeading: 'Amount' ].
	self model expenses do: [ :each | self renderExpense: each on: html ] ].
]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> renderHeaderOn: html [
		
	html heading: 'Clipper Adams, Inc.'.
	html heading level: 2; with: 'Monthly Expense Report'.
	html heading level: 3; with:  'January 2008'.
	html heading level: 4; with:  'Name: Sean DeNigris'.
	html horizontalRule.

]

{ #category : #'as yet unclassified' }
ExpenseRecorder >> renderTotalsByAccountOn: html [
	
	html heading level: 4; with: self model accountTotalsTitle.
	html table: [
		html tableRow: [
			self model accountTotalsColumnHeadings do: [ :h |
				html tableHeading: h ] ].
		self model accountsAndTotalsDo: [ :a :total |
				html tableRow: [
					html tableData: a.
					html tableData: total ] ] ].
	html horizontalRule.
]
