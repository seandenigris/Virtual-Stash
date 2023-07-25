"
I represent a collection of transactions whose counterparty is the same string (actually a VsImportName). This string is considered to be my ""input"", for which I lookup rules to convert to a real counterparty.
"
Class {
	#name : #VsTransactionImportGroup,
	#superclass : #Object,
	#instVars : [
		'transactions',
		'input'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsTransactionImportGroup class >> example [

	| ta partyInput |
	ta := VsTransaction example.
	partyInput := VsImportName fromString: ta counterparty fullName.
	partyInput transaction: ta.
	ta 
		counterparty: partyInput;
		importedName: partyInput.
	^ self new
		transactions: {  ta };
		yourself
]

{ #category : #accessing }
VsTransactionImportGroup >> accounts [
	^ (self transactions flatCollect: [ :e | e splits collect: #account ]) asSet
]

{ #category : #accessing }
VsTransactionImportGroup >> addressBook [

	^ MpAddressBook uniqueInstance
]

{ #category : #actions }
VsTransactionImportGroup >> applyRule: aRule [
	self transactions do: [ :t | t applyRule: aRule copy ]
]

{ #category : #accessing }
VsTransactionImportGroup >> beOrgTitleCased [
	| rule |
	rule := VsImportRule
		genericPartiesEnsureNamed: self input suggestion
		aliases: #().
	self transactions do: [ :t | 
		rule
			transaction: t;
			apply ]
]

{ #category : #accessing }
VsTransactionImportGroup >> bePerson [
	| person |
	person := self addressBook ensurePersonNamed: self input suggestion.
	self transactions do: [ :t | t counterparty: person ]
]

{ #category : #accessing }
VsTransactionImportGroup >> counterparty [
	^ self transactions first counterparty
]

{ #category : #accessing }
VsTransactionImportGroup >> counterparty: party [
	self transactions do: [ :t | t counterparty: party ]
]

{ #category : #accessing }
VsTransactionImportGroup >> counterpartyImportElement [
	^ VsCounterpartyImportElement new
		transactionGroup: self;
		yourself.
]

{ #category : #'acessing-magritte' }
VsTransactionImportGroup >> descriptionContainer [
	"Return the default description container."
	<magritteContainer>
	^ super descriptionContainer
		blocClass: MACompositeElementBuilder;
		yourself
]

{ #category : #accessing }
VsTransactionImportGroup >> gtViewGeneralJournalOn: aView [
	<gtView>
	| result |
	result := aView columnedList
		title: 'Journal' translated;
		priority: 50;
		items: [ self transactions flatCollect: [ :t | t journalLines ] ];
		send: #model;
		yourself.
	VsJournalLine configureGtColumnedList: result.
	^ result
]

{ #category : #accessing }
VsTransactionImportGroup >> gtViewPartyImportOn: aView [
	<gtView>
	^ aView explicit
		title: 'Import';
		priority: 2;
		stencil: [ self counterpartyImportElement ]
]

{ #category : #accessing }
VsTransactionImportGroup >> gtViewRulesOn: aView [
	"Adapted from GtRefactoringsElement"

	<gtView>
	^ aView tree
		title: 'Rules';
		priority: 3;
		items: [ VsImportRule all
			select: [ :r | self transactions allSatisfy: [ :t | r appliesTo: t ] ] ];
		children: [ :e | 
			e transaction
				ifNil: [ self transactions collect: [ :t | 
					e copy transaction: t; yourself ] ]
				ifNotNil: [ #() ] ];
		itemType: [ :aTypeFactory :aTreeNode | 
			aTreeNode value transaction
				ifNotNil: [ MAPatchMacroElement ]
				ifNil: [ VsImportRuleElement ] ];
		itemStencil: [ :aNodeType | aNodeType new ];
		itemDataBinder:
				[ :anElement :aRule :anIndex | anElement rule: aRule targetingGroup: self ];
		actionUpdateButton;
		yourself
]

{ #category : #accessing }
VsTransactionImportGroup >> input [
	^ input
]

{ #category : #accessing }
VsTransactionImportGroup >> input: anObject [
	input := anObject
]

{ #category : #accessing }
VsTransactionImportGroup >> magritteDescription [
	| desc field acc |
	self flag: 'do we need #descriptionContainer?'.
	desc := self transactions first magritteDescription
		blocClass: MACompositeElementBuilder;
		yourself.
	field := #transactions.
	desc children do: [ :e | MACompositeAccessor via: field using: e ].
	^ desc
]

{ #category : #accessing }
VsTransactionImportGroup >> memo [
	^ self transactions first memo
]

{ #category : #accessing }
VsTransactionImportGroup >> paymentProcessor: anMpOrganization [
	self transactions do: [ :t | t processor: anMpOrganization ]
]

{ #category : #accessing }
VsTransactionImportGroup >> paymentProcessorInput [
	^ self input paymentProcessor
]

{ #category : #accessing }
VsTransactionImportGroup >> printOn: aStream [
	aStream nextPutAll: self todoString
]

{ #category : #accessing }
VsTransactionImportGroup >> rankedMatches [

	| choices reply |
	choices := MpAddressBook uniqueInstance contacts collect: #fullName.
	reply := PBApplication uniqueInstance newCommandStringFactory
    addAllBindings: { 
        #choices -> choices asArray.
        #maxResults -> 50.
        #input -> self input counterpartyName } asDictionary;
    script: 'from fuzzywuzzy import process';
    resultExpression: 'process.extract(input, choices, limit=maxResults)';
    sendAndWait.
    ^ reply
    
    "Note: We let fuzzywuzzy use the default (and slower) Ratcliff-Obershelp algorithm[1] from difflib, rather than load Levenstein distance [3] because a sequence-based algorithm seems more appropriate [3]
    
    1. https://github.com/seatgeek/fuzzywuzzy/issues/128#issuecomment-766208348
    2. https://pypi.org/project/fuzzywuzzy/
    3. https://itnext.io/string-similarity-the-basic-know-your-algorithms-guide-3de3d7346227"
]

{ #category : #accessing }
VsTransactionImportGroup >> searchWWW [
	| url |
	url := 'http://www.google.com/search' asUrl
		queryAt: 'q' put: self counterparty displayString.
	LibC system: 'open "', url asString, '"'
]

{ #category : #accessing }
VsTransactionImportGroup >> size [
	^ self transactions size
]

{ #category : #accessing }
VsTransactionImportGroup >> todoString [
	^ self size asString, ' ', self transactions atRandom importedName string
]

{ #category : #accessing }
VsTransactionImportGroup >> transactions [
	^ transactions
]

{ #category : #accessing }
VsTransactionImportGroup >> transactions: aCollection [
	transactions := aCollection.
	input := self counterparty.
]
