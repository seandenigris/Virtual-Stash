expenses
expensesFor: month of: year
	"The arguments can be numbers, numbers as strings. For the month, the name also.
	E.g. VsBooks expensesFor: 1 | '1' | 'January' of: 2008 | '2008'"

	| firstDayOfMonth lastDayOfMonth |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	^ reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].