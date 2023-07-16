"
I am a *Journal* (accounting lingo italicized). My *entries* represent financial *transactions*.

self asMagritteMorph addButtons; openInWindow.
self addTransaction: ()

"
Class {
	#name : #VsGeneralJournal,
	#superclass : #Object,
	#instVars : [
		'entries'
	],
	#classInstVars : [
		'business',
		'personal'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsGeneralJournal class >> business [
	^ business ifNil: [ business := self new ]
]

{ #category : #accessing }
VsGeneralJournal class >> business: anObject [
	business := anObject
]

{ #category : #accessing }
VsGeneralJournal class >> personal [
	^ personal ifNil: [ personal := self new ]
]

{ #category : #accessing }
VsGeneralJournal class >> personal: anObject [
	personal := anObject
]

{ #category : #'as yet unclassified' }
VsGeneralJournal class >> restoreFrom: aCollection [

	business := aCollection first.
	personal := aCollection second
]

{ #category : #'adding/removing' }
VsGeneralJournal >> add: entry [

	^ self entries add: entry
]

{ #category : #'adding/removing' }
VsGeneralJournal >> addAll: transactionCollection [

	^ self entries addAll: transactionCollection
]

{ #category : #magritte }
VsGeneralJournal >> asMorph [

	^ self asMagritteMorph addButtons; morph
]

{ #category : #magritte }
VsGeneralJournal >> descriptionEntries [
	<magritteDescription>
	^ MAToManyRelationDescription new
			accessor: #entries;
			label: 'Entries';
			display: [ :e | e size asString , ' entries' ];
			classes: {VsTransaction};
			priority: 100;
			beRequired;
			yourself
]

{ #category : #accessing }
VsGeneralJournal >> entries [

	^ entries ifNil: [ entries := SortedCollection sortUsing: #date descending undefinedFirst ]
]

{ #category : #accessing }
VsGeneralJournal >> entriesGtViewOn: aView [
	<gtView>
	| result |
	result := aView columnedList
		title: 'General Journal' translated;
		priority: 5;
		items: [ self transactions flatCollect: [ :t | t journalLines ] ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result
]

{ #category : #accessing }
VsGeneralJournal >> gtSearchTransactionsFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Transactions';
		priority: 2;
		items: [ self transactions ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
VsGeneralJournal >> gtViewImportEditorOn: aView [
	<gtView>
	| result |
	^ aView columnedList
		title: 'Import Editor' translated;
		priority: 20;
		items: [ (self todos at: 24) last ];
		"send: #self;"
		column: 'Input' do: [ :clm | 
			clm stencil: [ :e | 
			"BlTextElement new
		text: e counterparty asRopedText;
		yourself."
			BrEditor new
		look: BrGlamorousEditorLook;
		text: e counterparty;
		fitContent;
		yourself.
		"BlElement new
				background: Color blue;
				yourself" ] ];
		yourself.
]

{ #category : #accessing }
VsGeneralJournal >> gtViewTodosOn: aView [
	<gtView>
	| result itemStencil contextMenuContents actions |
	
	actions := {
		'Title Cased Org' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item beOrgTitleCased ].
		'Person' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item bePerson ].
		'WWW Search' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item searchWWW ]
	}.
	
	contextMenuContents := [ BrGlamorousSimpleContextMenuContent new
		items: actions;
		yourself ].
	itemStencil := [ :anArray | 
	BrLabel new
		aptitude:
			BrGlamorousLabelAptitude
				+ (BrGlamorousWithContextMenuAptitude content: contextMenuContents);
		padding:
			(BlInsets
				top: 0
				left: 0
				bottom: 0
				right: 3);
		constraintsDo: [ :c | c linear horizontal alignLeft ];
		yourself ].
	^ aView tree
		title: 'TODO' translated;
		priority: 10;
		items: [ self todos ];
		itemStencil: itemStencil;
		itemDataBinder: [ :elem :item | 
			elem text: item todoString asRopedText.
			elem userData at: #todo put: item ];
		actionUpdateButtonTooltip: 'Update list';
		yourself
]

{ #category : #accessing }
VsGeneralJournal >> todos [
	| todos todoStringSet dashboard |
	todos := entries select: [ :e | e counterparty isKindOf: VsImportName ].
	todoStringSet := todos collect: #counterparty as: Set.
	dashboard := todoStringSet
		collect: [ :s | 
			| effected |
			effected := todos select: [ :t | t counterparty = s ].
			VsTransactionImportGroup new
				transactions: effected;
				yourself ].
	^ dashboard asOrderedCollection sort: #size descending
]

{ #category : #'as yet unclassified' }
VsGeneralJournal >> transactions [
	^ self entries
]

{ #category : #accessing }
VsGeneralJournal >> transactionsSortedByStringCounterparty [
	^ (self transactions select: [ :e | e counterparty isString ] thenCollect: #counterparty) asSet asSortedCollection
]
