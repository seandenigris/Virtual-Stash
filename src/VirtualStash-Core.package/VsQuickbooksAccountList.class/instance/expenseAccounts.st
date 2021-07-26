as yet unclassified
expenseAccounts

	| temp |
	self flag: 'OMG, Ican''t believe you actually wrote this! Bad!!!'.
	temp := self allAccounts select: [ :e | e type = VsQbExpenseAccountType ].
	^ temp copyWith: (VsQuickbooksAccount new
			name: 'Travel & Entertainment:Meals:Edinburgh';
			type: VsQbExpenseAccountType)