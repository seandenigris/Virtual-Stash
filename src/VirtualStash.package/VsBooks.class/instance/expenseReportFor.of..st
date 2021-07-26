as yet unclassified
expenseReportFor: month of: year
	"See expenseReportFor:of: for acceptable argument values"

	| firstDayOfMonth lastDayOfMonth monthlyExpenses |
	firstDayOfMonth := Date year: year month: month day: 1.
	lastDayOfMonth := firstDayOfMonth onNextMonth - 1 days.
	monthlyExpenses := reimbursibleExpenses select: [ :e | e date >= firstDayOfMonth and: [ e date <= lastDayOfMonth ] ].
	^ VsExpenseReport on: monthlyExpenses.