"
I represent the commercial terms of an agreement during one effective period.

My start is inclusive. My end is exclusive, so a successor may start on the same date that I cease to apply. A nil end means that I remain effective indefinitely.

My price records the vendor-stated economic price as an Aconcagua money-per-time quantity—for example, '100' dollars / 1 year or '1800' dollars / 6 months. My billingInterval separately records how often payment is requested—for example, 1 month. This permits the user to preserve the figures supplied by the vendor without converting a six-month premium into a monthly amount.

Multiplying my price by my billingInterval may provide a nominal expected installment, but I do not model a complete payment schedule. Down payments, installment fees, uneven payments, due dates, and other schedule details should become separate concepts only when a concrete workflow requires them.
"
Class {
	#name : 'VsAgreementTerm',
	#superclass : 'Object',
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'start',
		'end',
		'price',
		'billingInterval'
	],
	#category : 'VirtualStash-Core-Agreements',
	#package : 'VirtualStash-Core',
	#tag : 'Agreements'
}

{ #category : 'accessing - payment' }
VsAgreementTerm >> billingInterval [
	"Answer how often payment is requested under these terms."

	^ billingInterval
]

{ #category : 'accessing - payment' }
VsAgreementTerm >> billingInterval: aQuantity [
	"Set how often payment is requested under these terms."

	billingInterval := aQuantity
]

{ #category : 'magritte-accessing' }
VsAgreementTerm >> billingIntervalDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #billingInterval;
		classes: { Quantity };
		priority: 400;
		comment: 'How often payment is requested, such as one month. This is distinct from the period used to express the price.';
		yourself
]

{ #category : 'printing' }
VsAgreementTerm >> displayStringOn: aStream [
	"Print a concise description of my effective period, price, and billing cadence."

	self start
		ifNil: [ aStream nextPutAll: 'Unscheduled' ]
		ifNotNil: [ :aDate | aStream display: aDate ].
	aStream nextPutAll: ' – '.
	self end
		ifNil: [ aStream nextPutAll: 'ongoing' ]
		ifNotNil: [ :aDate | aStream display: aDate ].
	self price ifNotNil: [ :aPrice |
		aStream
			nextPutAll: ' — ';
			display: aPrice ].
	self billingInterval ifNotNil: [ :anInterval |
		aStream
			nextPutAll: ', billed every ';
			display: anInterval ]
]

{ #category : 'accessing - effective period' }
VsAgreementTerm >> end [
	"Answer the first date on which I am no longer effective.

	Answer nil when I have no known end."

	^ end
]

{ #category : 'accessing - effective period' }
VsAgreementTerm >> end: aDate [
	"Set the first date on which I am no longer effective."

	end := aDate
]

{ #category : 'magritte-accessing' }
VsAgreementTerm >> endDescription [
	<magritteDescription>
	"Describe my optional, exclusive effective end."

	^ MADateDescription new
		accessor: #end;
		priority: 200;
		comment: 'The first date on which these terms no longer apply. Leave empty when they remain effective indefinitely.';
		yourself
]

{ #category : 'testing' }
VsAgreementTerm >> includesDate: aDate [
	"Answer whether I am effective on aDate.

	My start is inclusive and my end is exclusive."

	self start ifNil: [ ^ false ].

	self start > aDate ifFalse: [ ^ false ].
	
	^ self end isNil or: [ aDate < self end ]
]

{ #category : 'accessing - payment' }
VsAgreementTerm >> price [
	"Answer my vendor-stated economic price as a money-per-time quantity.

	My billingInterval separately records how often payment is requested."

	^ price
]

{ #category : 'accessing - payment' }
VsAgreementTerm >> price: aQuantity [
	"Set my vendor-stated economic price as a money-per-time quantity."

	price := aQuantity
]

{ #category : 'magritte-accessing' }
VsAgreementTerm >> priceDescription [
	<magritteDescription>
	"Describe my vendor-stated money-per-time price."

	^ MAToOneRelationDescription new
		accessor: #price;
		classes: { Quantity };
		priority: 300;
		beRequired;
		comment: 'The economic price expressed per unit of time, such as $100 per year or $1,800 per six months.';
		yourself
]

{ #category : 'printing' }
VsAgreementTerm >> printOn: aStream [
	"Print me using my display string."

	self printFromDisplayStringOn: aStream
]

{ #category : 'accessing - effective period' }
VsAgreementTerm >> start [
	"Answer the first date on which I am effective."

	^ start
]

{ #category : 'accessing - effective period' }
VsAgreementTerm >> start: aDate [
	"Set the first date on which I am effective."

	start := aDate
]

{ #category : 'magritte-accessing' }
VsAgreementTerm >> startDescription [
	<magritteDescription>
	"Describe my inclusive effective start."

	^ MADateDescription new
		accessor: #start;
		priority: 100;
		beRequired;
		comment: 'The first date on which these terms apply.';
		yourself
]
