"
## Chart of Accounts
For discussion on how/why to set up, see {{gtClass:VsAccount|show=#gtCoderCommentsFor:}}

"
Class {
	#name : #VsBooks,
	#superclass : #Object,
	#instVars : [
		'title',
		'generalJournal',
		'chartOfAccounts'
	],
	#classVars : [
		'PaymentProcessors'
	],
	#classInstVars : [
		'personal',
		'business',
		'oldPersonal'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #persistence }
VsBooks class >> all [
	^ { self personal. self business }
]

{ #category : #'instance creation' }
VsBooks class >> business [

	^ business ifNil: [ business := self new title: 'Business'; yourself ].
]

{ #category : #accessing }
VsBooks class >> ensurePaymentProcessorNamed: aString [
	| p |
	p := MpAddressBook default ensureOrganizationNamed: aString.
	^ self paymentProcessors add: p.
]

{ #category : #examples }
VsBooks class >> exampleHarryPotter [
	<gtExample>
	^ self
		given: [ VsBooks new ]
		when: [ :books | 
			books importAccountsFromGnuCashCSV: BaselineOfVirtualStash exampleSupportFolder / 'gnu_cash_accounts_potter.csv'.
			books transactionImporter
				addressBook: MpAddressBook exampleHarryPotter;
				source: BaselineOfVirtualStash exampleSupportFolder / 'gnu_cash_2_transactions_export.csv';
				execute.
			books ]
		then: [ :books | books generalJournal entries should haveSize: 2 ]
]

{ #category : #accessing }
VsBooks class >> paymentProcessors [
	^ PaymentProcessors ifNil: [ PaymentProcessors := Set new ]
]

{ #category : #accessing }
VsBooks class >> paymentProcessors: anObject [
	PaymentProcessors := anObject
]

{ #category : #'instance creation' }
VsBooks class >> personal [

	^ personal ifNil: [ personal := self new title: 'Personal'; yourself ].
]

{ #category : #persistence }
VsBooks class >> restoreFrom: aCollection [

	personal := aCollection first.
	business := aCollection second.
	oldPersonal := aCollection third.
	PaymentProcessors := aCollection fourth
]

{ #category : #persistence }
VsBooks class >> spData [

	^ { personal. business. oldPersonal. PaymentProcessors }
]

{ #category : #'paying credit cards' }
VsBooks >> accounts [
	^ self chartOfAccounts ifNotNil: [ :coa | coa accounts ].
]

{ #category : #'account-compatibility' }
VsBooks >> books [
	"Baskstop to simplify account implementation"
	^ self
]

{ #category : #'account-compatibility' }
VsBooks >> chart [
	"Polymorphic with account to find children; maybe combine this and #accounts into something that works for both? Maybe #chartOfAccounts"
	^ self chartOfAccounts accounts
]

{ #category : #accessing }
VsBooks >> chartOfAccounts [
	^ self maLazyInstVarUsing: self chartOfAccountsDescription
]

{ #category : #accessing }
VsBooks >> chartOfAccounts: aCollection [
	chartOfAccounts := aCollection
]

{ #category : #'magritte-accessing' }
VsBooks >> chartOfAccountsDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #chartOfAccounts;
		default: (VsChartOfAccounts new books: self; yourself);
		shouldCacheDefault: true;
		yourself
]

{ #category : #serializing }
VsBooks >> fuelOutAs: base [
	"Stash obsolete data somewhere so we can start over"
	FLSerializer serialize: self toFileNamed: (FileLocator virtualStashData / 'Fuelouts' / base, 'fuel') fullName
]

{ #category : #accessing }
VsBooks >> fullName [
	"To be polymorphic with Account. Other alternative is #accountFullName, which would be clearer in this context but redundant from account perspective"
	^ ''
]

{ #category : #accessing }
VsBooks >> generalJournal [
	^ generalJournal ifNil: [ generalJournal := VsGeneralJournal new ]
]

{ #category : #accessing }
VsBooks >> generalJournal: anObject [
	generalJournal := anObject
]

{ #category : #accessing }
VsBooks >> generalJournalElementExample [
	| ts tFields container rowTemplate cellTemplate blankTemplate headerCells anyT anyS sFields tCells sCells cell1Widths newWidth |
	ts := self generalJournal transactions first: 5.
	anyT := ts first.
	anyS := anyT splits first.
	tFields := { anyT dateDescription. anyT numberDescription. anyT counterpartyDescription }.
	sFields := {
						anyS accountDescription.
						(anyS statusDescription
							display: [ :e | e class gnuCashCode ];
							yourself).
						anyS debitAmountDescription.
						anyS creditAmountDescription}.			
	container := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		yourself.
	rowTemplate := BrValuableStencil
		from: [ BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 22 ];
				yourself ].
	cellTemplate := BrValuableStencil
		from: [ BlTextElement new
				border: (BlBorder paint: Color black width: 1);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 20 ];
				padding: (BlInsets all: 5);
				background: Color paleGreen darker darker darker darker;
				yourself ].
	blankTemplate := BrValuableStencil
		from: [ BlTextElement new
				text: '' asRopedText;
				border: (BlBorder paint: Color black width: 1);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 20 ];
				padding: (BlInsets all: 5);
				background: Color paleGreen darker darker darker darker;
				yourself ].
	headerCells := tFields , sFields
		collect: [ :desc | 
			cellTemplate create
				text: desc label asRopedText;
				yourself ].
	container
		addChild:
			(rowTemplate create
				addChildren: headerCells;
				yourself).
	ts
		do: [ :t | 
			tCells := tFields
				collect: [ :desc | 
					cellTemplate create
						text: (desc toString: (desc read: t)) asRopedText;
						yourself ].
			tCells := tCells
				,
					{blankTemplate create.
					blankTemplate create.
					blankTemplate create}.
			container
				addChild:
					(rowTemplate create
						addChildren: tCells;
						yourself).
			t splits
				do: [ :s | 
					sCells := sFields
						collect: [ :desc | 
							cellTemplate create
								text: (desc toString: (desc read: s)) asRopedText;
								yourself ].
					sCells := {blankTemplate create.
					blankTemplate create.
					blankTemplate create} , sCells.
					container
						addChild:
							(rowTemplate create
								addChildren: sCells;
								yourself) ] ].
	container forceLayout.
	cell1Widths := container children
		collect: [ :e | e children first width ].
	newWidth := cell1Widths max.
	container children do: [ :e | e children first width: newWidth ].
	^ container
]

{ #category : #accessing }
VsBooks >> gtSearchAccountsFor: aStep [
	<gtSearch>
	^ (self chartOfAccounts gtSearchAccountsFor: aStep)
		priority: 20;
		yourself
]

{ #category : #accessing }
VsBooks >> gtSearchTransactionsFor: aStep [
	<gtSearch>
	^ (self generalJournal gtSearchTransactionsFor: aStep)
		priority: 10;
		yourself
]

{ #category : #accessing }
VsBooks >> importAccountsFromGnuCashCSV: file [
	| accnts |
	self accounts isEmptyOrNil ifFalse: [ self error: 'this doesn''t handle books with existing accounts' ].
	accnts := VsAccount importAllFromGnuCash: file.
	accnts do: [ :e | e books: self ].
	self chartOfAccounts accounts: accnts
]

{ #category : #accessing }
VsBooks >> importDefaultAccountsFromGnuCash [
	self importAccountsFromGnuCashCSV: '/Users/sean/Documents/Reference/Smalltalk/User Data/Virtual Stash/Accounts/gnu_cash_account_tree.csv' asFileReference.
]

{ #category : #'personal expenses' }
VsBooks >> initialize [

	super initialize.
	accounts := Set new.
]

{ #category : #printing }
VsBooks >> printOn: aStream [
	aStream
		nextPutAll: self title;
		nextPutAll: ' books'
]

{ #category : #'as yet unclassified' }
VsBooks >> printRegister: account [
	| transactions balance |
	transactions := self generalJournal transactions select: [ :trans | trans accounts includes: account ].
	balance := account openingBalance.
	^ String streamContents: [ :str |
			transactions
				do: [ :t | str
					nextPutAll: t registerString;
					tab;
					print: balance ]
				separatedBy: [ str crlf ] ]
]

{ #category : #accessing }
VsBooks >> title [
	^ title ifNil: [ '' ]
]

{ #category : #accessing }
VsBooks >> title: anObject [
	title := anObject
]

{ #category : #accessing }
VsBooks >> transactionImporter [
	"Example:
		self transactionImporter
			sourceFile: FileLocator virtualStashData / 'gnu_cash_personal_transactions_all-2020-11-25.csv';
			execute"
	^ VsTransactionImporter new 
		books: self;
		targetCollection: self generalJournal transactions.
]
