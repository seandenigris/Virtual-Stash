Class {
	#name : #VsQuickbooksAccountList,
	#superclass : #Object,
	#category : 'VirtualStash-QuickBooks'
}

{ #category : #'as yet unclassified' }
VsQuickbooksAccountList >> allAccounts [

	^ VsQbAccountListIIF new accounts.
]

{ #category : #'as yet unclassified' }
VsQuickbooksAccountList >> expenseAccounts [

	| temp |
	self flag: 'OMG, Ican''t believe you actually wrote this! Bad!!!'.
	temp := self allAccounts select: [ :e | e type = VsQbExpenseAccountType ].
	^ temp copyWith: (VsQuickbooksAccount new
			name: 'Travel & Entertainment:Meals:Edinburgh';
			type: VsQbExpenseAccountType)
]
