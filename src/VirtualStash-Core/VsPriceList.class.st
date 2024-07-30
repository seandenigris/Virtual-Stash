Class {
	#name : #VsPriceList,
	#superclass : #Object,
	#instVars : [
		'prices'
	],
	#classInstVars : [
		'UniqueInstance'
	],
	#category : #'VirtualStash-Core-Vendors'
}

{ #category : #persistence }
VsPriceList class >> restoreFrom: anObject [

	UniqueInstance := anObject.
]

{ #category : #persistence }
VsPriceList class >> spData [

	^ UniqueInstance
]

{ #category : #accessing }
VsPriceList class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
VsPriceList class >> uniqueInstance: anObject [
	UniqueInstance := anObject
]

{ #category : #'as yet unclassified' }
VsPriceList >> add: aVsItemPrice [ 
	
	^ self prices add: aVsItemPrice
]

{ #category : #accessing }
VsPriceList >> itemSearchNewFor: aSearch [
	<gtSearch>
	
	^ VsPrice 
		search: self
		new: VsItemPrice
		for: aSearch 
		priority: 200
]

{ #category : #accessing }
VsPriceList >> packageSearchNewFor: aSearch [
	<gtSearch>
	
	^ VsPrice 
		search: self
		new: VsPackagePrice
		for: aSearch 
		priority: 100
]

{ #category : #accessing }
VsPriceList >> priceFor: aVsItem [ 
	
	| itemPrices |
	itemPrices := self prices select: [ :e | e item = aVsItem ].
	^ itemPrices
		ifNotEmpty: [ itemPrices detectMax: #date ]
		ifEmpty: [ aVsItem unknownPrice ]
]

{ #category : #accessing }
VsPriceList >> prices [
	^ prices ifNil: [ prices := OrderedCollection new ]
]

{ #category : #accessing }
VsPriceList >> prices: anObject [
	prices := anObject
]

{ #category : #accessing }
VsPriceList >> pricesGtSearchOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Prices';
		priority: 2;
		items: [ self prices ];
		itemName: #displayString;
		matchSubstrings
]

{ #category : #accessing }
VsPriceList >> pricesGtViewOn: aView [
	<gtView>
	
	| result |
	result := aView columnedList
		title: 'Prices' translated;
		priority: 5;
		items: [ self rootPrices ];
		actionUpdateButton;
		yourself.
		
	VsPrice magritteTemplate magritteDescription do: [ :desc |
		result column: desc label text: [ :line | desc readToString: line ] ].
				
	^ result
]

{ #category : #accessing }
VsPriceList >> rootPrices [

	^ self prices reject: #isPrivate
]
