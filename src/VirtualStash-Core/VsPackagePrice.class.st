Class {
	#name : #VsPackagePrice,
	#superclass : #VsPrice,
	#instVars : [
		'itemPrices',
		'name'
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
VsPackagePrice >> date [

	self refreshPrices.

	^ self itemPrices 
		ifNotEmpty: [ :pxs | pxs min: #date ]
		ifEmpty: [ nil ]
]

{ #category : #accessing }
VsPackagePrice >> displayStringOn: aStream [

	self name ifNotNil: [ :n | aStream << n ]
]

{ #category : #accessing }
VsPackagePrice >> item [
	"Item Price compatibility"

	^ nil
]

{ #category : #accessing }
VsPackagePrice >> itemPrices [
	^ itemPrices  ifNil: [ itemPrices := OrderedCollection new ]
]

{ #category : #accessing }
VsPackagePrice >> itemPrices: anObject [
	itemPrices := anObject
]

{ #category : #accessing }
VsPackagePrice >> itemPricesDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: #itemPrices;
		referenceDisplay: #displayString;
		classes: { VsItemPrice. VsUnknownPrice };
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
		items: [ self itemPrices ];
		actionUpdateButton.
		
	VsItemPrice new magritteDescription do: [ :desc |
		result column: desc label text: [ :line | desc readToString: line ] ].
				
	^ result
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
VsPackagePrice >> priceList [

	^ VsPriceList uniqueInstance
]

{ #category : #accessing }
VsPackagePrice >> refreshPrices [

	self itemPrices
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

	^ self itemPrices
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
