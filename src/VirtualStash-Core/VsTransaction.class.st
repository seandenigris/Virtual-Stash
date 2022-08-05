"
I represent a financial transaction, like a credit card purchase. I have at least two {{gtClass:VsSplit|label=splits}}, possibly more.
# Numbering
I can have a unique ID and philosophically my {{gtClass:VsSplit|label=splits}} can have their own individual IDs.
# Optional Fields
GnuCash's sqlite DB stores these in a separate *slots* table, presumably to save space. At this point, it seems like premature optimization, so we do TSTTCPW, which is to treat them as just another field.
- Memo: commonly used for relatively few transactions
# Importing from GnuCash
We start with CSV format, since we already have  a parser for that. The tricky bit is that each row consists of transaction fields followed by split fields. The first row is completely filled out and represents the transaction along with its first split. This is followed by one or more rows with just the split filled out, which are additional splits for that previous transaction.

"
Class {
	#name : #VsTransaction,
	#superclass : #Object,
	#traits : 'MATPropertyOwner + VsTTransactable',
	#classTraits : 'MATPropertyOwner classTrait + VsTTransactable classTrait',
	#instVars : [
		'accountSource',
		'addressBook',
		'date',
		'memo',
		'number',
		'receipt',
		'reference',
		'splits',
		'voidReason',
		'counterparty',
		'processor'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsTransaction class >> example [
	^ self new
		counterparty: MpOrganization examplePhillyZoo;
		yourself
]

{ #category : #testing }
VsTransaction class >> isAbstract [
	^ false
]

{ #category : #'as yet unclassified' }
VsTransaction class >> memo: aString append: anotherString [

	^ String streamContents: [ :s |
		aString ifNotEmpty: [ :m | 
			s nextPutAll: m; nextPutAll: '; ' ].
		s nextPutAll: anotherString ].
]

{ #category : #accessing }
VsTransaction >> accountSource [
	"One reason we have to store this is that new snippets need to know it, and we pass it to them"
	^ accountSource
]

{ #category : #accessing }
VsTransaction >> accountSource: anObject [
	accountSource := anObject
]

{ #category : #accessing }
VsTransaction >> accounts [
	^ self splits collect: #account
]

{ #category : #'magritte-accessing' }
VsTransaction >> accountsDescription [
	"Used by e.g. ==#printRegister:== to select relevant transactions"
	^ MAMultipleOptionDescription new
		accessor: #accounts;
		beReadonly;
		comment: 'a.k.a. Category, which seems more aimed at the casual user, rather than accounting industry standard';
		yourself
]

{ #category : #accessing }
VsTransaction >> addressBook [

	^ addressBook ifNil: [ addressBook := MpAddressBook default ]
]

{ #category : #accessing }
VsTransaction >> addressBook: anObject [

	addressBook := anObject
]

{ #category : #accessing }
VsTransaction >> amount [
	| credits debits creditTotal debitTotal |
	credits := self splits select: #isCredit.
	debits := self splits select: #isDebit.
	creditTotal := credits inject: 0 dollars into: [ :sum :e | sum + e amount ].
	debitTotal := debits inject: 0 dollars into: [ :sum :e | sum + e amount ].
	^ { creditTotal. debitTotal } detectMax: #abs
]

{ #category : #'magritte-accessing' }
VsTransaction >> amountDescription [
	"<magritteDescription>"
	^ MANumberDescription new
		accessor: #amount;
		display: [ :e | '$' , e asString ];
		priority: 500;
		beReadOnly;
		yourself
]

{ #category : #accessing }
VsTransaction >> applyRule: aVsCounterpartyRule [
	aVsCounterpartyRule
		transaction: self;
		apply.
]

{ #category : #GnuCash }
VsTransaction >> commodity [
	^ self maLazyPropertyUsing: self commodityDescription
]

{ #category : #GnuCash }
VsTransaction >> commodity: aString [
	self
		propertyAt: self commodityDescription accessor readSelector
		put: aString
]

{ #category : #GnuCash }
VsTransaction >> commodityDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #commodity;
		default: 'CURRENCY::USD';
		propertyAt: #csvFieldName put: 'Commodity/Currency';
		yourself
]

{ #category : #accessing }
VsTransaction >> counterparty [
	^ counterparty
]

{ #category : #accessing }
VsTransaction >> counterparty: anObject [
	counterparty := anObject
]

{ #category : #'magritte-accessing' }
VsTransaction >> counterpartyDescription [
	
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #counterparty;
			gtSearchSource: (MessageSend receiver: self selector: #addressBook);
			priority: 300;
			comment: 'Often called the ==payee== in accounting software, but this is misleading. The payee of a refund is the user, but is that really what we want to know? No! GnuCash gives up altogether and puts a free-form ==description== field where the ==payee== usually goes. Counterparty is the most precise term, meaning the entity on the other side of the transaction.';
			yourself
]

{ #category : #accessing }
VsTransaction >> date [
	^ date
]

{ #category : #accessing }
VsTransaction >> date: anObject [
	date := anObject
]

{ #category : #GnuCash }
VsTransaction >> gnuCashCounterpartyDescription: aDescription [
	<magritteDescription: #counterpartyDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Description';
		yourself
]

{ #category : #GnuCash }
VsTransaction >> gnuCashDateDescription: aDescription [
	<magritteDescription: #dateDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Date';
		yourself
]

{ #category : #GnuCash }
VsTransaction >> gnuCashID [
	^ self maLazyPropertyUsing: self gnuCashIDDescription
]

{ #category : #GnuCash }
VsTransaction >> gnuCashID: aString [
	self
		propertyAt: self gnuCashIDDescription accessor readSelector
		put: aString
]

{ #category : #GnuCash }
VsTransaction >> gnuCashIDDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #gnuCashID;
		propertyAt: #csvFieldName put: 'Transaction ID';
		yourself
]

{ #category : #GnuCash }
VsTransaction >> gnuCashMemoDescription: aDescription [
	<magritteDescription: #memoDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Notes';
		yourself
]

{ #category : #GnuCash }
VsTransaction >> gnuCashNumberDescription: aDescription [
	<magritteDescription: #numberDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Transaction Number';
		yourself
]

{ #category : #GnuCash }
VsTransaction >> gnuCashVoidReasonDescription: aDescription [
	<magritteDescription: #voidReasonDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Void Reason';
		yourself
]

{ #category : #accessing }
VsTransaction >> gtViewJournalOn: aView [
	<gtView>
	| result |
	result := aView columnedList
		title: 'Splits' translated;
		priority: 5;
		items: [ self journalLines ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result
]

{ #category : #accessing }
VsTransaction >> importedName [
	^ self maLazyPropertyUsing: (self importedNameDescription)
]

{ #category : #accessing }
VsTransaction >> importedName: aString [
	self propertyAt: #importedName put: aString
]

{ #category : #'magritte-accessing' }
VsTransaction >> importedNameDescription [
	^ MAStringDescription new
		accessor: #importedName;
		yourself
]

{ #category : #accessing }
VsTransaction >> isValid [
	^ self date isNotNil
]

{ #category : #GnuCash }
VsTransaction >> journalColumnThreeDescription [
	^ self counterpartyDescription
]

{ #category : #accessing }
VsTransaction >> journalLines [
	^ OrderedCollection new
		add: self;
		addAll: self splits;
		collect: [ :e |
			VsJournalLine new 
				model: e;
				yourself ]
]

{ #category : #accessing }
VsTransaction >> memo [
	^ self maLazyInstVarUsing: self memoDescription
]

{ #category : #accessing }
VsTransaction >> memo: anObject [
	memo := anObject
]

{ #category : #accessing }
VsTransaction >> memoAppend: aString [
	memo := self class memo: memo append: aString
]

{ #category : #'magritte-accessing' }
VsTransaction >> memoDescription [
	"The term 'memo' seems to be the industry standard. a.k.a. 'notes' (also a good name) and 'description', which we ruled out to avoid confusion because GnuCash uses it as a poor-man's 'payee' field"
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #memo;
		priority: 300;
		default: '';
		yourself
]

{ #category : #accessing }
VsTransaction >> number [
	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : #accessing }
VsTransaction >> number: aNumber [
	number := aNumber
]

{ #category : #printing }
VsTransaction >> printOn: aStream [
	{ self dateDescription. self amountDescription. self counterpartyDescription. self memoDescription } 
		do: [ :d | aStream maPrint: d for:  self ]
		separatedBy: [ aStream space ]
]

{ #category : #accessing }
VsTransaction >> processor [
	^ processor
]

{ #category : #accessing }
VsTransaction >> processor: anObject [
	processor := anObject
]

{ #category : #'magritte-accessing' }
VsTransaction >> processorDescription [
	
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #processor;
			options: MpAddressBook default organizations;
			priority: 550;
			yourself
]

{ #category : #accessing }
VsTransaction >> receipt [
	^ receipt
]

{ #category : #accessing }
VsTransaction >> receipt: anObject [
	receipt := anObject
]

{ #category : #'magritte-accessing' }
VsTransaction >> receiptDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #receipt;
			classes: { VsReceipt };
			priority: 700;
			yourself
]

{ #category : #accessing }
VsTransaction >> registerString [
	^ (self maToString: self dateDescription), '	', (self maToString: self counterpartyDescription), '	', (self maToString: self accountsDescription), '	', (self maToString: self amountDescription)
]

{ #category : #accessing }
VsTransaction >> splits [
	^ self maLazyInstVarUsing: self splitsDescription.
]

{ #category : #accessing }
VsTransaction >> splits: anObject [
	splits := anObject
]

{ #category : #'magritte-accessing' }
VsTransaction >> splitsDescription [
	<magritteDescription>
	"On naming... Also seems to be called ==entries== in some accounting software. We chose ==splits== because it is more specific and therefor intention revealing e.g. can't be confused with journal entries, which is somewhat related, but different"
	^ MAToManyRelationDescription new
			accessor: #splits;
			default: OrderedCollection new;
			classes: { VsSplit };
			initializer: [ :inst | 
				inst
					accountSource: self accountSource;
					amount: self uncategorizedAmount ];
			priority: 400;
			yourself
]

{ #category : #accessing }
VsTransaction >> uncategorizedAmount [

	| categorizedAmount |
	categorizedAmount := self entries inject: 0 into: [ :sum :e | sum + e amount ].
	^ self amount - categorizedAmount
]

{ #category : #GnuCash }
VsTransaction >> voidReason [
	^ self maLazyInstVarUsing: self voidReasonDescription
]

{ #category : #GnuCash }
VsTransaction >> voidReason: aString [
	voidReason := aString
]

{ #category : #GnuCash }
VsTransaction >> voidReasonDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (MAPropertyAccessor key: #voidReason);
		yourself
]
