"
I represent an agreement whose financial consequences may be recorded in VirtualStash.

My provider is the party supplying the subject of the agreement. My subject is the
first-class Dynabook object the agreement concerns—for example, the Trello object
from CwSoftwareCatalog. My price applies once per billingInterval beginning on
effectiveStart.

I deliberately model the currently effective terms directly. Once amendments or
historical terms are needed, those terms should become effective-dated objects rather
than mutating me in a way that rewrites history.
"
Class {
	#name : 'VsAgreement',
	#superclass : 'Object',
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'provider',
		'subject',
		'billingInterval',
		'price',
		'effectiveStart'
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

{ #category : 'magritte-accessing' }
VsAgreement >> billingIntervalDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #billingInterval;
		label: 'Billing interval';
		classes: { Quantity };
		priority: 300;
		beRequired;
		comment: 'The period covered by each price, such as one month or one year.';
		yourself
]

{ #category : 'accessing' }
VsAgreement >> displayStringOn: aStream [

	self subject
		ifNotNil: [ :anObject | aStream display: anObject ]
		ifNil: [ aStream nextPutAll: 'Agreement' ].
	self provider ifNotNil: [ :anObject |
		aStream
			nextPutAll: ' — ';
			display: anObject ]
]

{ #category : 'accessing' }
VsAgreement >> effectiveStart [

	^ effectiveStart
]

{ #category : 'accessing' }
VsAgreement >> effectiveStart: aDate [

	effectiveStart := aDate
]

{ #category : 'magritte-accessing' }
VsAgreement >> effectiveStartDescription [
	<magritteDescription>

	^ MADateDescription new
		accessor: #effectiveStart;
		priority: 500;
		beRequired;
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

{ #category : 'magritte-accessing' }
VsAgreement >> priceDescription [
	<magritteDescription>

	^ MAMoneyDescription vsNew
		accessor: #price;
		priority: 400;
		beRequired;
		comment: 'The amount charged for one billing interval.';
		yourself
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
