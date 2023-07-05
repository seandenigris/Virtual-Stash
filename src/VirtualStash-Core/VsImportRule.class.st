"
I apply to imported transactions where the counterparty field begins with my party's name or alias, followed by optional additional info. For example:
- Additional info {{gtExample:VsCounterpartyRule class>>#exampleAcme}}
- No additional info {{gtExample:VsCounterpartyRule class>>#exampleAirbnb}}
# Scenarios
The simplest scenario is when someone already manually broke down the ""vendor + random-other-info"" spit out by many transaction formats into `vendor` + `memo`. So now you have a string which is the same as the vendor and the other info stored in the memo. You can update them to a real model like so:
```
name := 'Amazon'.
vendor := MpOrganization named: name.
transactionCollection ""veryDeepCopy"" do: [ :t | t counterparty: vendor ]
```
To do a test run, uncomment the `#veryDeepCopy` send.
# Subclasses
Should set `partyName` and override `partyParser`
# Hueristics
Common patterns of description/payee fields:
1. The whole thing is the party name
2.  The first ""word"" is the party
3. The first two words is the party
4. The whole thing is the party

In all cases, the vendor name may be all caps and have to be title cased. Also, for each pattern, `party` could be replaced by `alias`
# Followup
1. When something is a restaurant, do we put ""restaurant"" in the name? For typing reasons, if it doesn't conflict and the user knows it without, defer to the simplest thing. However, that is valid meta-information that could be put in the memo, or even better, into the tags.
2. Amazon Visa uses:
	- 'PURCHASE INTEREST CHARGE' for interest charges; interest account
	- 'AUTOMATIC PAYMENT - THANK' for payments; transfer account
There could be a rule about that. For either the payee would be the card issuer. Or maybe credit card accounts can have that meta-info?

"
Class {
	#name : #VsImportRule,
	#superclass : #Object,
	#instVars : [
		'transaction',
		'partyName',
		'partyAliases',
		'addressBook',
		'party',
		'parsingResult',
		'paymentProcessor',
		'memo',
		'counterpartyInput',
		'patch'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsImportRule class >> all [
	^ self generic, ((VsImportRule allSubclasses reject: #isAbstract) collect: #new) "We refer to the class explicitly so that this works the same from the subclasses"
]

{ #category : #accessing }
VsImportRule class >> allFor: aTransaction [
	^ self all 
		select: [ :e | e appliesTo: aTransaction ]
		thenCollect: [ :r | 
			r
				transaction: aTransaction;
				yourself ]
]

{ #category : #testing }
VsImportRule class >> appliesTo: aVsTransaction [
	^ self new appliesTo: aVsTransaction
]

{ #category : #'examples-support' }
VsImportRule class >> assert: transaction hasVendorNamed: aString [
	self assert: transaction counterparty name equals: aString
]

{ #category : #accessing }
VsImportRule class >> displayName [
	^ (self name allButFirst: 'Vs' size) allButLast: 'ImportRule' size
]

{ #category : #accessing }
VsImportRule class >> elementClass [
	^ VsImportRuleElement
]

{ #category : #accessing }
VsImportRule class >> exampleAcme [
	<gtExample>
	self
		givenInput: 'ACME #1234'
		thenPartyNamed: 'Acme'
		andMemoAppendedWith: '#1234'
]

{ #category : #examples }
VsImportRule class >> exampleAdobe [
	<gtExample>
	self
		givenInput: 'Adobe Creative Cloud'
		thenPartyNamed: 'Adobe'
		andMemoAppendedWith: 'Creative Cloud'
]

{ #category : #accessing }
VsImportRule class >> exampleAirbnb [
	<gtExample>
	self givenInput: 'AIRBNB' thenPartyNamed: 'Airbnb'
]

{ #category : #accessing }
VsImportRule class >> exampleAirbnbAsteriskMemo [
	<gtExample>
	self givenInput: 'AIRBNB * AB34FG78JK' thenPartyNamed: 'Airbnb' andMemoAppendedWith: 'AB34FG78JK'
]

{ #category : #accessing }
VsImportRule class >> exampleAirbnbMemo [
	<gtExample>
	self givenInput: 'AIRBNB  AB34FG78JK' thenPartyNamed: 'Airbnb' andMemoAppendedWith: 'AB34FG78JK'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonAMZN [
	<gtExample>
	self
		givenInput: 'AMZN Digital*12CD56GH9'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: 'Digital*12CD56GH9'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonDotCom [
	<gtExample>
	self
		givenInput: 'Amazon.com*12CD56GH9'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: '12CD56GH9'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonMagazine [
	<gtExample>
	self
		givenInput: 'AmazonMagzne'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: 'Magzne'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonMusic [
	<gtExample>
	self
		givenInput: 'Amazon Music*12CD56GH9'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: 'Music*12CD56GH9'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonPrime [
	<gtExample>
	self
		givenInput: 'Amazon Prime'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: 'Prime'
]

{ #category : #examples }
VsImportRule class >> exampleAmazonVideo [
	<gtExample>
	self
		givenInput: 'Amazon Video'
		thenPartyNamed: 'Amazon'
		andMemoAppendedWith: 'Video'
]

{ #category : #accessing }
VsImportRule class >> exampleAmericasTestKitchen [
	<gtExample>
	self givenInput: 'BCP*AMERICASTESTKITCHE' thenPartyNamed: 'America''s Test Kitchen'
]

{ #category : #accessing }
VsImportRule class >> exampleBP [
	<gtExample>
	self
		given: 'BP#1234567BRONX BP'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'BP' ]
		andMemoAppendedWith: '#1234567BRONX BP'
]

{ #category : #accessing }
VsImportRule class >> exampleCostco [
	<gtExample>
	self
		given: 'COSTCO WHSE #1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Costco' ]
		andMemoAppendedWith: 'WHSE #1234'
]

{ #category : #accessing }
VsImportRule class >> exampleCostcoDotCom [
	<gtExample>
	self
		given: 'WWW COSTCO COM'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Costco' ]
		andMemoAppendedWith: 'COM'
]

{ #category : #accessing }
VsImportRule class >> exampleDunkin [
	<gtExample>
	self
		given: 'DUNKIN #123456 A23'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Dunkin' ]
		andMemoAppendedWith: '#123456 A23'
]

{ #category : #accessing }
VsImportRule class >> exampleDunkinDonuts [
	<gtExample>
	self
		given: 'Dunkin Donuts'
		appliedTo: [  ]
		then: [ :r :t | 
			self assert: t counterparty name equals: 'Dunkin'.
			self assert: t memo equals: '' ]
]

{ #category : #accessing }
VsImportRule class >> exampleDunkinMobile [
	<gtExample>
	self
		given: 'DUNKIN'' MOBILE'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Dunkin' ]
		andMemoAppendedWith: 'MOBILE'
]

{ #category : #accessing }
VsImportRule class >> exampleHomeDepot [
	<gtExample>
	self
		given: 'THE HOME DEPOT 1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Home Depot' ]
		andMemoAppendedWith: '1234'
]

{ #category : #accessing }
VsImportRule class >> exampleSunoco [
	<gtExample>
	self
		given: 'SUNOCO 1234567890'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Sunoco' ]
		andMemoAppendedWith: '1234567890'
]

{ #category : #accessing }
VsImportRule class >> exampleTJMaxx [
	<gtExample>
	self
		given: 'TJMAXX #1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'T.J. Maxx' ]
		andMemoAppendedWith: '#1234'
]

{ #category : #accessing }
VsImportRule class >> exampleTarget [
	<gtExample>
	self
		given: 'TARGET        12345678'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Target' ]
		andMemoAppendedWith: '12345678'
]

{ #category : #accessing }
VsImportRule class >> exampleTargetDotCom [
	<gtExample>
	self
		given: 'TARGET.COM  *'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Target' ]
		andMemoAppendedWith: '.COM *'
]

{ #category : #examples }
VsImportRule class >> exampleTossibleDigits [
	<gtExample>
	self
		givenInput: 'Tossable Digits'
		thenPartyNamed: 'Tossable Digits'
]

{ #category : #accessing }
VsImportRule class >> exampleTossibleDigitsExtraGibberish [
	<gtExample>
	self
		given: 'Tossable Digits Toss'
		appliedTo: [  ]
		then: [ :r :t | 
			self assert: t counterparty name equals: 'Tossable Digits'.
			self assert: t memo isEmpty ]
]

{ #category : #accessing }
VsImportRule class >> exampleTraderJoes [
	<gtExample>
	self
		given: 'TRADER JOE''S #123 ABC'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Trader Joe''s' ]
		andMemoAppendedWith: '#123 ABC'
]

{ #category : #accessing }
VsImportRule class >> exampleUSPS [
	<gtExample>
	self
		given: 'USPS PO 1234567890'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'USPS' ]
		andMemoAppendedWith: 'PO 1234567890'
]

{ #category : #examples }
VsImportRule class >> exampleUber [
	<gtExample>
	self
		given: 'Uber.Com'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Uber' ]
		andMemoAppendedWith: '.Com'
]

{ #category : #examples }
VsImportRule class >> exampleWWJW [
	<gtExample>
	self
		given: 'Westchester Join PAYMENT    1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Westchester Joint Water Works' ]
		andMemoAppendedWith: 'PAYMENT 1234'
]

{ #category : #examples }
VsImportRule class >> exampleWestchesterMall [
	<gtExample>
	self
		given: 'THE WESTCHESTER MALL PARK'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Westchester Mall' ]
		andMemoAppendedWith: 'PARK'
]

{ #category : #examples }
VsImportRule class >> exampleWholeFoods [
	<gtExample>
	self
		given: 'WHOLEFDS ABC#12345'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Whole Foods' ]
		andMemoAppendedWith: 'ABC#12345'
]

{ #category : #examples }
VsImportRule class >> exampleZara [
	<gtExample>
	self
		given: 'ZARA USA 1234'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Zara' ]
		andMemoAppendedWith: 'USA 1234'
]

{ #category : #examples }
VsImportRule class >> exampleZaraDotCom [
	<gtExample>
	self
		given: 'ZARA.COM.USA'
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: 'Zara' ]
		andMemoAppendedWith: 'COM.USA'
]

{ #category : #accessing }
VsImportRule class >> for: aTransaction [
	^ (self allFor: aTransaction)
		ifNotEmpty: [ :rules | rules first ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
VsImportRule class >> generic [

	^ MpAddressBook uniqueInstance organizations asEntityCollection collect: #vsCounterpartyRule
	
	"Implementation note: these used to be generated from literal pairs so that they were automatically persisted with the code. In the future, if released publicly, this might be a valid strategy to seed the rules with well-known vendors, or perhaps the address book should be so-seeded. Anyway, the current commit before the new system is be4b83be"
]

{ #category : #accessing }
VsImportRule class >> genericPartiesEnsureNamed: aString aliases: aCollection [
	| rule rules sourceCode |
	rules := self generic asSortedCollection: #partyName ascending.
	rules 
		detect: [ :e | e partyName = aString ]
		ifFound: [ :e | ^ e ]
		ifNone: [ 
			rule := VsImportRule new
				partyName: aString;
				partyAliases: aCollection;
				yourself.
			rules add: rule ].
	sourceCode := String streamContents: [ :str |
	str nextPutAll: 'genericParties
	^ #(
		"Name" "Alias"'.
	rules do: [ :r | 
		| aliasesToStore |
		str cr; tab; tab; print: r partyName; space.
		aliasesToStore := r partyAliases ifEmpty: [ nil ].
		aliasesToStore storeOn: str ].
	str cr; tab; nextPutAll: ').' ].
	self class compile: sourceCode classified: 'accessing'.
	^ rule
	
]

{ #category : #'examples-support' }
VsImportRule class >> given: counterpartyString appliedTo: transactionBlock then: assertionBlock [
	self
		given: [ | t |
			t := VsTransaction new
				importedName: counterpartyString;
				yourself.
			transactionBlock cull: t.
			t ]
		when: [ :t |
			| matches |
			matches := self all select: [ :e | e appliesTo: t ].
			self assert: matches size equals: 1.
			matches first
				addressBook: MpAddressBook new;
				transaction: t;
				apply;
				yourself ]
		then: assertionBlock
]

{ #category : #'examples-support' }
VsImportRule class >> given: counterpartyString appliedTo: transactionBlock then: assertionBlock andMemoAppendedWith: addedMemo [
	| originalMemo |
	self
		given: counterpartyString
		appliedTo: transactionBlock
		then: assertionBlock.
	originalMemo := 'something'.
	self
		given: counterpartyString
		appliedTo: [ :t | 
			transactionBlock cull: t.
			t memo: originalMemo ]
		then: [ :r :t |
			assertionBlock cull: r cull: t.
			self assert: (t memo beginsWith: originalMemo).
			self assert: (t memo endsWith: addedMemo) ]
]

{ #category : #'examples-support' }
VsImportRule class >> givenInput: inputString thenPartyNamed: partyNameString [
	self
		given: inputString
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: partyNameString ]
]

{ #category : #'examples-support' }
VsImportRule class >> givenInput: inputString thenPartyNamed: partyNameString andMemoAppendedWith: memoString [
	self
		given: inputString
		appliedTo: [  ]
		then: [ :r :t | self assert: t counterparty name equals: partyNameString ]
		andMemoAppendedWith: memoString
]

{ #category : #accessing }
VsImportRule class >> gtViewGenericsOn: aView [
	<gtClassView>
	| orgColor |
	^ aView mondrian
		title: 'Generics' translated;
		priority: 50;
		painting: [ :mondrian | 
			mondrian nodes
				shape: [ :rule | 
					| aliasColor |
					aliasColor := Color red.
					MpAddressBook default contacts
						detect: [ :e | e fullName = rule partyName ]
						ifFound: [ :org | 
							| orgAs ruleAs |
							orgColor := Color gray.
							aliasColor := Color black.
							orgAs := org aliases.
							ruleAs := rule partyAliases asSet.
							orgAs = ruleAs
								ifFalse: [ 
									(ruleAs difference: orgAs) ifNotEmpty: [ aliasColor := Color green ].
									(orgAs difference: ruleAs) ifNotEmpty: [ aliasColor := Color yellow ] ] ]
						ifNone: [ orgColor := Color purple ].
					BlElement new
						border: (BlBorder paint: aliasColor width: 10);
						background: orgColor;
						constraintsDo: [ :constraints | constraints padding: (BlInsets all: 50) ] ];
				with: self generic.
			mondrian layout grid ];
		send: [ :rule | 
			{rule.
			(MpAddressBook default contacts
				detect: [ :e | e fullName = rule partyName ]
				ifNone: [ nil ])} ]
]

{ #category : #accessing }
VsImportRule class >> gtViewHierarchyExamplesFor: aView [
    <gtClassView>
    | examples |
	examples := self withAllSubclasses flatCollect: #gtExamplesContained.
    ^ ((GtExampleGroup withAll: examples) gtExamplesFor: aView)
        title: 'Examples, All' translated;
        priority: 17
]

{ #category : #accessing }
VsImportRule class >> partyAliases [
	^ #()
]

{ #category : #accessing }
VsImportRule >> = rhs [
	^ self class = rhs class and: [ self partyName = rhs partyName and: [ self partyAliases = rhs partyAliases ] ].
]

{ #category : #accessing }
VsImportRule >> accountNamed: fullNameString [

	^ self transaction accountSource accounts detect: [ :e | e fullName = fullNameString ]
]

{ #category : #accessing }
VsImportRule >> addressBook [
	"Hook for testing so we don't pollute the default AddressBook"
	^ addressBook ifNil: [ MpAddressBook uniqueInstance ]
]

{ #category : #accessing }
VsImportRule >> addressBook: aBook [
	addressBook := aBook
]

{ #category : #testing }
VsImportRule >> appliesTo: aVsTransaction [
	^ self parser matches: aVsTransaction importedName string
]

{ #category : #testing }
VsImportRule >> apply [
	^ self patch execute
]

{ #category : #applying }
VsImportRule >> buildPatchOperations [
	
	self patchSet: #counterpartyDescription to: self party.
	self patchMemoAppend: self memo
]

{ #category : #'accessing-convenience' }
VsImportRule >> credit [
	| result |
	result := self transaction splits select: #isCredit.
	result size = 1 ifFalse: [ self error: 'Rules assume only one credit and one debit' ].
	^ result first
]

{ #category : #'accessing-convenience' }
VsImportRule >> debit [
	| result |
	result := self transaction splits select: #isDebit.
	result size = 1 ifFalse: [ self error: 'Rules assume only one credit and one debit' ].
	^ result first
]

{ #category : #accessing }
VsImportRule >> displayName [
	^ self class displayName
]

{ #category : #accessing }
VsImportRule >> elementClass [
	^ MAPatchMacroElement
]

{ #category : #private }
VsImportRule >> extraInfoParser [
	^ #any asPParser star flatten trimBlanks optional ==> [ :n | n ifNotNil: [ :s | s withBlanksCondensed trimBoth ] ]
]

{ #category : #accessing }
VsImportRule >> gtPatchViewFor: aView [
	<gtView>
	self patch ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Patch';
		priority: 25;
		object: [ self patch ];
		view: #gtElementViewFor:
]

{ #category : #accessing }
VsImportRule >> hash [
	^ self partyName hash bitXor: self partyAliases hash
]

{ #category : #testing }
VsImportRule >> input [
	^ self transaction importedName
]

{ #category : #accessing }
VsImportRule >> memo [
	^ memo ifNil: [ memo := self parsingResult last ]
]

{ #category : #accessing }
VsImportRule >> memo: aString [
	memo := aString
]

{ #category : #accessing }
VsImportRule >> parser [
	^ self primaryParser, self separatorParser, self extraInfoParser end
]

{ #category : #private }
VsImportRule >> parsingResult [
	^ parsingResult ifNil: [ parsingResult := self parser parse: self input string ].
]

{ #category : #accessing }
VsImportRule >> party [
	^ party ifNil: [ self addressBook ensureOrganizationNamed: self partyName ].
]

{ #category : #accessing }
VsImportRule >> party: anMpRelatableEntity [
	party := anMpRelatableEntity.
	self partyName: party fullName.
	self partyAliases: party aliases
]

{ #category : #accessing }
VsImportRule >> partyAliases [
	^ partyAliases ifNil: [ self class partyAliases ]
]

{ #category : #accessing }
VsImportRule >> partyAliases: aCollection [
	partyAliases := aCollection
]

{ #category : #accessing }
VsImportRule >> partyName [
	^ partyName
]

{ #category : #accessing }
VsImportRule >> partyName: anObject [
	partyName := anObject
]

{ #category : #applying }
VsImportRule >> patch [
	^ patch 
		ifNotNil: [ patch ]
		ifNil: [ 
			patch := MAPatchMacro new.
			self buildPatchOperations.
			patch ].
]

{ #category : #applying }
VsImportRule >> patchMemoAppend: aString [
	| newMemo |
	aString isEmptyOrNil ifTrue: [ ^ self ].
	newMemo := VsTransaction memo: self transaction memo append: aString.
	self patchSet: #memoDescription to: newMemo
]

{ #category : #applying }
VsImportRule >> patchSet: fieldSymbol to: anObject [
	self patch 
		addOperationFor: self transaction 
		set: (self transaction perform: fieldSymbol) 
		to: anObject.
]

{ #category : #accessing }
VsImportRule >> paymentProcessor [
	^ paymentProcessor
]

{ #category : #accessing }
VsImportRule >> primaryParser [
	self subclassResponsibility
]

{ #category : #testing }
VsImportRule >> primaryParserFromOptions: aCollectionOfStrings [

	^ aCollectionOfStrings 
		inject: PP2FailingNode instance 
		into: [ :result :str | result / str asPParser ]
]

{ #category : #accessing }
VsImportRule >> printOn: aStream [
	aStream nextPutAll: (self className allButFirst: 'Vs' size) normalizeCamelCase
]

{ #category : #accessing }
VsImportRule >> separatorParser [
	^ ($* asPParser / $- asPParser / #space asPParser) star
]

{ #category : #accessing }
VsImportRule >> transaction [
	^ self maLazyInstVarUsing: self transactionDescription
]

{ #category : #accessing }
VsImportRule >> transaction: anObject [
	transaction := anObject.
	counterpartyInput := transaction importedName
]

{ #category : #'magritte-accessing' }
VsImportRule >> transactionDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #transaction;
		yourself
]

{ #category : #accessing }
VsImportRule >> user [
	^ self addressBook vsUsers first
]
