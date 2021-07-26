private
showExpensesFor: aMonth

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