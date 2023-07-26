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
	
	^ self 
		searchNew: VsItemPrice
		for: aSearch 
		priority: 200
]

{ #category : #accessing }
VsPriceList >> packageSearchNewFor: aSearch [
	<gtSearch>
	
	^ self 
		searchNew: VsPackagePrice
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
		matchSubstrings;
		send: #copy
]

{ #category : #accessing }
VsPriceList >> pricesGtViewOn: aView [
	<gtView>
	
	| result |
	result := aView columnedList
		title: 'Prices' translated;
		priority: 5;
		items: [ self prices ];
		actionUpdateButton;
		yourself.
		
	VsPrice new magritteDescription do: [ :desc |
		result column: desc label text: [ :line | desc readToString: line ] ].
				
	^ result
]

{ #category : #accessing }
VsPriceList >> searchNew: aClass for: aSearch priority: aNumber [
	
	^ aSearch explicit
		title: 'New ', (aClass name allButFirst: 'Vs' size);
		itemName: #displayString;
		priority: aNumber;
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			{ aClass named: input } asAsyncStream ];
		send: [ :result | self add: result ]
]
