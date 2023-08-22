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

{ #category : #accessing }
VsPackagePrice >> add: aVsItem [
	^ self addItem: aVsItem
]

{ #category : #accessing }
VsPackagePrice >> add: anInteger ofItem: aVsItem [

	| itemPrice |
	itemPrice := aVsItem price copy
		quantity: anInteger;
		yourself.
		
	^ self itemPrices add: itemPrice.
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
VsPackagePrice >> children: anObject [
	children := anObject
]

{ #category : #accessing }
VsPackagePrice >> date [

	self refreshPrices.

	^ self children 
		ifNotEmpty: [ :pxs | pxs min: #date ]
		ifEmpty: [ nil ]
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
VsPackagePrice >> itemSearchNewFor: aSearch [
	<gtSearch>
	
	^ VsPrice 
		search:self
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
		search:self
		new: VsPackagePrice
		for: aSearch 
		priority: 100
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

	self refreshPrices.

	^ self children
		inject: 0
		into: [ :sum :price |
			price total ifNil: [ ^ nil ]. "we don't have a price for a component"
			sum + price total ]
]

{ #category : #accessing }
VsPackagePrice >> totalDescription [
	
	^ super totalDescription
		beReadOnly;
		yourself
]
