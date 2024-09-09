Class {
	#name : #VsPackagePrice,
	#superclass : #VsPrice,
	#instVars : [
		'name',
		'children'
	],
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #accessing }
VsPackagePrice class >> named: aString [

	^ self new
		name: aString;
		yourself
]

{ #category : #'as yet unclassified' }
VsPackagePrice >> * anInteger [ 
	
	| result |
	result := self copy.
	result children do: [ :e |
		e quantity: e quantity * anInteger ].
	^ result
]

{ #category : #accessing }
VsPackagePrice >> add: aVsItem [
	^ self addItem: aVsItem
]

{ #category : #accessing }
VsPackagePrice >> add: anInteger ofItem: aVsItemPrice [

	| line |
	line := VsPriceLine new
		price: aVsItemPrice;
		quantity: anInteger;
		yourself.
		
	self children add: line.
	self list add: aVsItemPrice
]

{ #category : #accessing }
VsPackagePrice >> addItem: aVsItem [
	^ self add: 1 ofItem: aVsItem
]

{ #category : #accessing }
VsPackagePrice >> children [
	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
VsPackagePrice >> children: aCollection [
	children := aCollection
]

{ #category : #accessing }
VsPackagePrice >> copyToList [

	| copy |
	copy := self copy
		name: self name , ' copy';
		yourself.
	^ self priceList add: copy
]

{ #category : #accessing }
VsPackagePrice >> date [

	self refreshPrices.

	^ self children 
		ifNotEmpty: [ :lines | lines min: #date ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
VsPackagePrice >> dateDescription [
	
	^ super dateDescription
		beReadOnly;
		yourself
]

{ #category : #accessing }
VsPackagePrice >> isPrivate [
	^ false
]

{ #category : #accessing }
VsPackagePrice >> item [
	"Item Price compatibility"

	^ nil
]

{ #category : #accessing }
VsPackagePrice >> itemPricesDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #children;
		referenceDisplay: #displayString;
		classes: VsPriceLine withAllSubclasses;
		gtSearchSource: (MessageSend receiver: self selector: #priceList);
		gtSearchTransform: [ :px | 
			VsPriceLine new
				price: px;
				yourself ];
		yourself
]

{ #category : #accessing }
VsPackagePrice >> itemPricesGtViewFor: aView [
	<gtView>
	
	| result |
	result := aView columnedList
		title: 'Components';
		priority: 50;
		items: [ self children ];
		actionUpdateButton.
		
	VsPriceLine magritteTemplate magritteDescription do: [ :desc |
		result column: desc label text: [ :line | desc readToString: line ] ].
				
	^ result
]

{ #category : #accessing }
VsPackagePrice >> itemSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Items (existing)';
		priority: 100;
		items: [ self priceList rootPrices ];
		filterBySubstring;
		send: [ :item | self addItem: item ]
]

{ #category : #accessing }
VsPackagePrice >> itemSearchNewFor: aSearch [
	<gtSearch>
	
	^ VsPrice 
		search: self
		new: VsItemPrice
		for: aSearch 
		priority: 200
]

{ #category : #accessing }
VsPackagePrice >> name [
	^ name
]

{ #category : #accessing }
VsPackagePrice >> name: anObject [
	name := anObject
]

{ #category : #accessing }
VsPackagePrice >> packageSearchNewFor: aSearch [
	<gtSearch>
	
	^ VsPrice 
		search: self
		new: VsPackagePrice
		for: aSearch 
		priority: 200
]

{ #category : #accessing }
VsPackagePrice >> postCopy [

	| lineCopies |
	super postCopy.
	
	lineCopies := self children collect: #copy.
	self children: lineCopies.
]

{ #category : #accessing }
VsPackagePrice >> priceList [

	^ VsPriceList uniqueInstance
]

{ #category : #accessing }
VsPackagePrice >> refreshPrices [

	self children
		select: [ :px | px isKindOf: VsUnknownPrice ]
		thenDo: [ :px |
			| latestPrice |
			latestPrice := VsPriceList uniqueInstance priceFor: px item.
			(latestPrice isKindOf: VsUnknownPrice) ifFalse: [
				self itemPrices replaceAll: px with: latestPrice ] ].
]

{ #category : #accessing }
VsPackagePrice >> total [

	self
		propertyAt: #total
		ifPresent: [ :total | ^ total ].

	self refreshPrices.

	^ self children
		inject: 0
		into: [ :sum :price |
			price total ifNil: [ ^ nil ]. "we don't have a price for a component"
			sum + price total ]
]

{ #category : #accessing }
VsPackagePrice >> total: money [

	self
		propertyAt: #total
		putRemovingNil: money.
]
