personal expenses
on: aDate iPaid: amount for: descriptionString categorizeAs: categoryString 

	reimbursibleExpenses add: (VsExpense
		paid: amount
		on: aDate
		for: descriptionString
		inCategory: (self category: categoryString)).