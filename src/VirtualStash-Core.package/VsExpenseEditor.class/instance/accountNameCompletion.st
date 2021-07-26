private
accountNameCompletion

	| applicants |
	applicants := VsQuickbooksAccountList new expenseAccounts collect: [ :e | e name ].

	^ EntryCompletion new
			dataSourceBlock: [:currText | applicants];
			filterBlock: [ :currApplicant :currText | 
				currText isEmpty or: [ currApplicant asUppercase includesSubstring: currText asString asUppercase ] ].