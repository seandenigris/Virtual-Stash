Class {
	#name : #VsChartOfAccounts,
	#superclass : #Object,
	#instVars : [
		'accounts',
		'books'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsChartOfAccounts >> accounts [
	^ self maLazyInstVarUsing: self accountsDescription
]

{ #category : #accessing }
VsChartOfAccounts >> accounts: aCollection [
	accounts := aCollection
]

{ #category : #'magritte-accessing' }
VsChartOfAccounts >> accountsDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #accounts;
		default: OrderedCollection new;
		yourself
]

{ #category : #accessing }
VsChartOfAccounts >> add: aVsAccount [
	aVsAccount books: self books.
	^ self accounts add: aVsAccount
	"Implementation note: I should be responsible for adding accounts, but to properly initialize them during that process, I must know my books"
]

{ #category : #accessing }
VsChartOfAccounts >> books [
	^ books
]

{ #category : #accessing }
VsChartOfAccounts >> books: aVsBooks [
	books := aVsBooks
]

{ #category : #accessing }
VsChartOfAccounts >> gtSearchAccountsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Accounts';
		priority: 1;
		allCandidates: [ self accounts ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
VsChartOfAccounts >> gtViewAllAccountsOn: aView [
	<gtView>
	^ aView columnedList
		title: 'Accounts (all)' translated;
		priority: 5;
		items: [ self accounts sorted: #name ascending ];
		column: 'Name' text: [ :e | e name ] width: 200;
		column: 'Parent' text: [ :e | 
			e parent 
				ifNotNil: [ :p | p  name ]
				ifNil: [ '' ] ];
		actionUpdateButtonTooltip: 'Update'.
]

{ #category : #accessing }
VsChartOfAccounts >> gtViewGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		painting: [ :m |
			m nodes
				stencil: [ :obj | 
					BlTextElement new
						text: obj name asRopedText;
						background: Color white;
						margin: (BlInsets all: 20);
						padding: (BlInsets all: 5);
						effect:
							(BlGaussianShadowEffect
								color: (Color gray alpha: 0.5)
								width: 5
								offset: 0 @ 0);
						yourself ];
				with: self accounts.
			m edges connectFrom: #parent.
			m layout horizontalTree.
			m ]
]
