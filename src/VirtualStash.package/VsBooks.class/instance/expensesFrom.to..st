as yet unclassified
expensesFrom: startDate to: endDate

	^ reimbursibleExpenses select: [ :e | e date >= startDate and: [ e date <= endDate ]]