private
descriptionCompletion

	| applicants |
	applicants := VsBooks uniqueInstance expensesCollect: [ :e | e description ].

	^ EntryCompletion new
			dataSourceBlock: [:currText | applicants asSet asArray ];
			filterBlock: [ :currApplicant :currText | 
				currApplicant asUppercase includesSubstring: currText asString asUppercase ].