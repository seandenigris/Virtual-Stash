"
I represent a durable agreement whose financial consequences may be recorded in VirtualStash.

My provider is the party supplying my subject. My subject is the first-class Dynabook object the agreement concerns—for example, a software product, service, event, property, or provisional PpValue used until a richer domain object emerges.

My ppValues identify the values and projects that I currently support or count toward. They describe why I am maintained rather than what I provide. Splits arising under me do not yet implicitly inherit these relationships.

My terms are effective-dated states of the continuing agreement. They record commercial facts that may change over time without replacing my durable identity. A term's price is a vendor-stated money-per-time quantity, while its billingInterval records how often payment is requested. Use #termsOn: to resolve the term effective on a particular date and #termsCurrent for the term effective today.

Terms begin on their inclusive start date and cease before their exclusive end date. A nil end means that a term remains effective indefinitely. Overlapping terms are ambiguous and cause #termsOn: to signal an error.

The legacy price, billingInterval, and effectiveStart slots remain temporarily so existing instances can be migrated safely with #termsMigrateLegacy. Remove those slots and their obsolete protocol after migration has been completed and verified.
"
Class {
	#name : 'VsAgreement',
	#superclass : 'Object',
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'provider',
		'subject',
		'ppValues',
		'billingInterval',
		'price',
		'effectiveStart',
		'terms'
	],
	#category : 'VirtualStash-Core-Agreements',
	#package : 'VirtualStash-Core',
	#tag : 'Agreements'
}

{ #category : 'accessing' }
VsAgreement >> addressBook [

	^ MpAddressBook uniqueInstance
]

{ #category : 'accessing' }
VsAgreement >> billingInterval [

	^ billingInterval
]

{ #category : 'accessing' }
VsAgreement >> billingInterval: aQuantity [

	billingInterval := aQuantity
]

{ #category : 'accessing' }
VsAgreement >> displayStringOn: aStream [

  self displaySubjectOn: aStream.
  self provider ifNotNil: [ :anObject |
      aStream
        nextPutAll: ' — ';
        display: anObject
    ]
]

{ #category : 'accessing' }
VsAgreement >> displaySubjectOn: aStream [

  self subject
    ifNotNil: [ :anObject | aStream display: anObject ]
    ifNil: [ aStream nextPutAll: 'Agreement' ]
]

{ #category : 'accessing' }
VsAgreement >> effectiveStart [

	^ effectiveStart
]

{ #category : 'accessing' }
VsAgreement >> effectiveStart: aDate [

	effectiveStart := aDate
]

{ #category : 'accessing' }
VsAgreement >> ppValues [

	^ self maLazyInstVarUsing: self ppValuesDescription
]

{ #category : 'accessing' }
VsAgreement >> ppValues: aCollection [

	ppValues := aCollection
		ifNotNil: [ :values | values asIdentitySet ]
]

{ #category : 'magritte-accessing' }
VsAgreement >> ppValuesDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #ppValues;
		label: 'Counts toward';
		gtSearchSource: #projectList;
		default: IdentitySet new;
		classes: PpValue withAllSubclasses;
		priority: 250;
		comment:
			'The values and projects that this agreement currently supports. Splits do not implicitly inherit these relationships.';
		yourself
]

{ #category : 'accessing' }
VsAgreement >> price [

	^ price
]

{ #category : 'accessing' }
VsAgreement >> price: aMoney [

	price := aMoney
]

{ #category : 'printing' }
VsAgreement >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing' }
VsAgreement >> provider [

	^ provider
]

{ #category : 'accessing' }
VsAgreement >> provider: aParty [

	provider := aParty
]

{ #category : 'magritte-accessing' }
VsAgreement >> providerDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #provider;
		gtSearchSource: (MessageSend receiver: self selector: #addressBook);
		classes: MpRelatableEntity allSubclasses;
		priority: 100;
		beRequired;
		comment: 'The person or organization that provides the agreement subject.';
		yourself
]

{ #category : 'accessing' }
VsAgreement >> subject [

	^ subject
]

{ #category : 'accessing' }
VsAgreement >> subject: anObject [

	subject := anObject
]

{ #category : 'magritte-accessing' }
VsAgreement >> subjectDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #subject;
		label: 'Subject';
		priority: 200;
		beRequired;
		comment: 'The first-class Dynabook object that the agreement concerns, such as a software product, property, work, or service.';
		yourself
]

{ #category : 'accessing' }
VsAgreement >> taxEntities [

  ^ self
  	propertyAt: #taxEntities
  	ifAbsent: [ nil ]
]

{ #category : 'accessing' }
VsAgreement >> taxEntities: aCollection [

  ^ self
  	propertyAt: #taxEntities
  	putRemovingNil: aCollection
]

{ #category : 'accessing' }
VsAgreement >> taxEntitiesDescription [
	<magritteDescription>

  ^ MAToManyRelationDescription new
  	accessor: #taxEntities;
  	gtSearchDelegateTo: [ VsBooks ] message: #reportingEntitiesGtSearchOn:;
  	default: OrderedCollection new;
  	classes: MpRelatableEntity allSubclasses;
  	yourself
]

{ #category : 'accessing - terms' }
VsAgreement >> terms [
	"Answer my effective-dated commercial terms."

	^ self maLazyInstVarUsing: self termsDescription
]

{ #category : 'accessing - terms' }
VsAgreement >> terms: aCollection [
	"Replace my effective-dated commercial terms with aCollection."

	terms := aCollection
]

{ #category : 'accessing - terms' }
VsAgreement >> termsAdd: anAgreementTerm [
	"Add anAgreementTerm to my terms and answer it."

	^ self terms add: anAgreementTerm.
]

{ #category : 'accessing - terms' }
VsAgreement >> termsCurrent [
	"Answer the term effective today, or nil when none is effective."

	^ self termsOn: Date today
]

{ #category : 'magritte-accessing' }
VsAgreement >> termsDescription [
	<magritteDescription>
	"Describe my effective-dated commercial terms."

	^ MAToManyRelationDescription new
		accessor: #terms;
		default: OrderedCollection new;
		classes: { VsAgreementTerm };
		priority: 300;
		comment: 'The effective-dated commercial terms of this continuing agreement.';
		yourself
]

{ #category : 'views' }
VsAgreement >> termsGtViewFor: aView [
	<gtView>
	"Show my terms in start-date order."

	terms ifNil: [ ^ aView empty ].
	self terms ifEmpty: [ ^ aView empty ].

	^ (aView maColumnedListOf: VsAgreementTerm)
		title: 'Terms';
		priority: 20;
		items: [ self termsSorted ];
		actionUpdateButton
]

{ #category : 'accessing - terms' }
VsAgreement >> termsOn: aDate [
	"Answer the sole term effective on aDate.

	Answer nil when no term is effective. Signal an error when overlapping
	terms make the answer ambiguous."

	| matchingTerms |
	matchingTerms := self terms select: [ :each | each includesDate: aDate ].
	matchingTerms ifEmpty: [ ^ nil ].
	matchingTerms size = 1 ifTrue: [ ^ matchingTerms anyOne ].

	self error: 'Agreement terms overlap on ', aDate printString
]

{ #category : 'accessing - terms' }
VsAgreement >> termsSorted [
	"Answer my terms in ascending start-date order."

	^ self terms asSortedCollection: #start ascending
]

{ #category : 'accessing' }
VsAgreement >> transactions [

  ^ VsBooks personal generalJournal iterator | [ :tnx | tnx agreements includes: self ] selectIt
    > VsGeneralJournal
]

{ #category : 'views' }
VsAgreement >> transactionsGtViewFor: aView [
  <gtView>
  
  self transactions entries ifEmpty: [ ^ aView empty ].
  
  ^ aView forward
      title: 'Transactions';
      object: [ self transactions ];
      view: #entriesGtViewOn:;
      inspectButtonFor: [ self transactions ]
]

{ #category : 'as yet unclassified' }
VsAgreement >> transactionsPush [

	self transactions entries do: [ :t | t agreement: self ]
]
