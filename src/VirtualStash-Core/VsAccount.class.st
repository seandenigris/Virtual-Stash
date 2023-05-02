"
# Chart of Accounts
An account can be created for two main reasons:
1. It distinguishes information that the user feels is valuable, and/or
2. It needs to be handled differently for tax reasons e.g. shows up on different lines of the return.
## Dimensions
A common place to run into trouble is when an account seems to properly exist in multiple places. For example, is ""Public Transportation"" ""Transportation"" or ""Travel"" or both (i.e. requiring two separate accounts)?  What if you live 30 minutes from a big city and take the train there? What if you're an hour away? Two? Does it matter why you went there (e.g. business or pleasure)? What if I own a plane and use it to commute?

The problem here is that things in life do not fit cleanly into one hierarchical tree. At best, one tree can capture a single dimension or aspect of the thing. Two of the most important dimensions in accounting (as in many other fields) are: *what* and *why*. For example, what did I spend this money on? I spent it on `Movie Tickets` And why did I spend it? I spent it for `Romance` because my `Wife` was dying to see that movie (although I wasn't really interested). Here we have an example of even a third dimension, which is a person connected to the *why*.

Perhaps a clearer example of when a person is a dimension is `Clothing`. We buy my clothing, my wife's clothing, and my daughter's clothing. Sure, I could create separate subaccounts for each, but consider all the other accounts that would have to be split up that way based on this logic - e.g. if we each had a car, a gym membership. Also, it wouldn't be so straightforward to analyze the expenditures of just one person because their expenses would be split up between all these accounts. The best you could do - if your software was flexible and powerful enough to support it, is match all the accounts named ""Wife"", but expression matching is error-prone at best. Imagine if your daughter was named Equity - not unthinkable in modern society - `Retained Earnings` and `Opening Balance` would show up as ""hers"".

The solution is to have multiple hierarchies representing the relevant dimensions, which allow items to be considered along multiple axes independently.

"
Class {
	#name : #VsAccount,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'isPlaceholder',
		'openingBalance',
		'name',
		'number',
		'parent',
		'notes',
		'books',
		'issuer'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsAccount class >> gnuCashType [
	| prefixSize |
	prefixSize := 2.
	^ (self name allButFirst: prefixSize) asUppercase allButLast: 'Account' size
]

{ #category : #importing }
VsAccount class >> importAllFromGnuCash: csvFile [
	^ (self maCSVImporter: VsAccountImporter)
		source: csvFile;
		execute.
]

{ #category : #'instance creation' }
VsAccount class >> named: aString [ 

	^ self new
			name: aString;
			yourself.
]

{ #category : #accessing }
VsAccount >> addChildNamed: aString [
	| child |
	child := (self class named: aString)
		parent: self;
		yourself.
	^ self books chartOfAccounts add: child
]

{ #category : #accessing }
VsAccount >> books [
	^ books
]

{ #category : #accessing }
VsAccount >> books: anObject [
	books := anObject
]

{ #category : #accessing }
VsAccount >> chart [
	^ self books chart
]

{ #category : #accessing }
VsAccount >> children [
	^ self chart select: [ :e | e parent = self ]
]

{ #category : #'magritte-accessing' }
VsAccount >> childrenDescription [
	<magritteDescription>
	<gtInspectorPresentationOrder: 10>
	^ MAToManyRelationDescription new
			accessor: #children;
			label: 'Children';
			yourself
]

{ #category : #accessing }
VsAccount >> displayStringOn: aStream [
	aStream nextPutAll: self name.
	self pathString ifNotEmpty: [ :str |
		aStream
			nextPutAll: ' (';
			nextPutAll: str;
			nextPut: $) ]
]

{ #category : #accessing }
VsAccount >> fullName [
	^ self pathString 
		ifEmpty: [ self name ]
		ifNotEmpty: [ :p | p, ':', self name ]
]

{ #category : #accessing }
VsAccount >> gnuCashAccountFullName [
	"The reason this selector is so complex (e.g. vs. #fullName) is that we need something unique to implement on ByteString while assembling the account tree from CSV"
	| path |
	path := parent ifNotNil: [ :p | p gnuCashAccountFullName, ':' ] ifNil: [ '' ].
	^ path, self name
]

{ #category : #utilities }
VsAccount >> isCredit: aNumber [
	^ self normalBalance = #credit
		ifTrue: [ aNumber > 0 ]
		ifFalse: [ aNumber < 0 ]
]

{ #category : #accessing }
VsAccount >> isPlaceholder [
	^ self maLazyInstVarUsing: self isPlaceholderDescription
]

{ #category : #accessing }
VsAccount >> isPlaceholder: aBoolean [
	isPlaceholder := aBoolean
]

{ #category : #'magritte-accessing' }
VsAccount >> isPlaceholderDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isPlaceholder;
		comment:
			'Account will be read-only; transactions can''t be directly added. Useful for structuring the chart of accounts.';
		default: false;
		csvFieldName: 'placeholder';
		csvReader: [ :str | str = 'T' ];
		yourself
]

{ #category : #accessing }
VsAccount >> issuer [
	^ self maLazyInstVarUsing: self issuerDescription
]

{ #category : #accessing }
VsAccount >> issuer: anObject [
	issuer := anObject
]

{ #category : #'magritte-accessing' }
VsAccount >> issuerDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #issuer;
		extensible: true;
		options: MpAddressBook uniqueInstance contacts;
		yourself
]

{ #category : #accessing }
VsAccount >> name [
	^ name
]

{ #category : #accessing }
VsAccount >> name: aString [
	name := aString
]

{ #category : #'magritte-accessing' }
VsAccount >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		csvFieldName: 'name';
		yourself
]

{ #category : #accessing }
VsAccount >> normalBalance [
	"Defined as 'Which side makes the balance go up - credit or debit?' Summarized *from Wikipedia>https://en.wikipedia.org/wiki/Normal_balance*.

Normal balance of common account types:
- Asset: Debit
- Liability: Credit
- Owner's Equity: Credit
- Revenue: Credit
- Expense: Debit
- Retained Earnings: Credit
- Dividend: Debit"

	"Credit as the 'default' is not a domain concept, but prevents duplication to pick one"
	^ #credit
]

{ #category : #accessing }
VsAccount >> notes [
	^ self maLazyInstVarUsing: self notesDescription
]

{ #category : #accessing }
VsAccount >> notes: aString [
	notes := aString
]

{ #category : #'magritte-accessing' }
VsAccount >> notesDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #notes;
		csvFieldName: #notes;
		yourself
]

{ #category : #accessing }
VsAccount >> number [
	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : #accessing }
VsAccount >> number: aNumber [
	number := aNumber
]

{ #category : #'magritte-accessing' }
VsAccount >> numberDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #number;
		yourself
]

{ #category : #accessing }
VsAccount >> openingBalance [
	^ openingBalance ifNil: [ openingBalance := self openingBalanceDescription default ]
]

{ #category : #accessing }
VsAccount >> openingBalance: anObject [
	openingBalance := anObject
]

{ #category : #'magritte-accessing' }
VsAccount >> openingBalanceDescription [
	<magritteDescription>
	^ MANumberDescription new
			accessor: #openingBalance;
			label: 'Opening Balance';
			default: 0;
			yourself
]

{ #category : #accessing }
VsAccount >> parent [
	^ self maLazyInstVarUsing: self parentDescription
]

{ #category : #accessing }
VsAccount >> parent: anObject [
	parent := anObject
]

{ #category : #'magritte-accessing' }
VsAccount >> parentDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #parent;
		extensible: true;
		options: #();
		csvFieldName: #full_name;
		csvReader: [ :str | 
			(str includesSubstring: ':')
				ifTrue: [ str copyUpToLast: $: ] ];
		yourself
]

{ #category : #accessing }
VsAccount >> pathString [
	^ parent ifNotNil: [ :p | p fullName ] ifNil: [ '' ]
]

{ #category : #printing }
VsAccount >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: ' Account'
]

{ #category : #utilities }
VsAccount >> rootFolder [
	^ FileLocator virtualStashData / 'Accounts' / self name
]

{ #category : #utilities }
VsAccount >> transactionsFromCSV_FileNamed: aString [
	| csvFile |
	csvFile := self rootFolder / 'Exports' / aString.
	^ (self class maCSVImporter: VsGnuCashTransactionImporter) importFile: csvFile.
]
