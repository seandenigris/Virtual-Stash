private
amountCompletion

	^ EntryCompletion new
			dataSourceBlock: [:currText | 
				| similarExpenses amounts |
				similarExpenses := VsPre2013Books uniqueInstance expensesSelect: [ :e | e description = description text ].
				amounts := similarExpenses collect: [ :e | e amount asString ].
				amounts asSet asArray ];
			filterBlock: [ :currApplicant :currText | 
				currApplicant asUppercase includesSubstring: currText asString asUppercase ].