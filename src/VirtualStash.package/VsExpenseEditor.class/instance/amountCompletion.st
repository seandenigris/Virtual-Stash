private
amountCompletion

	^ EntryCompletion new
			dataSourceBlock: [:currText | 
				| similarExpenses amounts |
				similarExpenses := VsBooks uniqueInstance expensesSelect: [ :e | e description = description text ].
				amounts := similarExpenses collect: [ :e | e amount asString ].
				amounts asSet asArray ];
			filterBlock: [ :currApplicant :currText | 
				currApplicant asUppercase includesSubstring: currText asString asUppercase ].