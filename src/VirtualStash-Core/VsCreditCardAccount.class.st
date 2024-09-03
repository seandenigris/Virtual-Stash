Class {
	#name : #VsCreditCardAccount,
	#superclass : #VsLiabilityAccount,
	#instVars : [
		'benefits',
		'foreignTransactionFee'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsCreditCardAccount class >> gnuCashType [
	^ 'CREDIT'
]

{ #category : #accessing }
VsCreditCardAccount >> benefits [
	^ benefits ifNil: [ benefits := OrderedCollection new ]
]

{ #category : #accessing }
VsCreditCardAccount >> convertAmexOldStyleFilenames [
	self statements
		select: [ :e | e file base beginsWith: 'Sta' ]
		thenCollect: [ :e | 
			| dateString month newBase |
			dateString := e file base copyAfter: $_.
			month := Month readFrom: dateString readStream.
			newBase := month year asString , '-'
				, (month index printStringPadded: 2).
			e moveFileTo: e parent / newBase , 'pdf' ]
]

{ #category : #accessing }
VsCreditCardAccount >> foreignTransactionFee [
	^ foreignTransactionFee
]

{ #category : #accessing }
VsCreditCardAccount >> foreignTransactionFee: aNumber [
	foreignTransactionFee := aNumber
]

{ #category : #accessing }
VsCreditCardAccount >> gtElementFor: aView [
	<gtView>
	| textElement text |
	text := ('**** **** **** ', self lastFour asString) asRopedText
		fontSize: 24;
		fontName: 'Courier';
		yourself.
		
	textElement := BlTextElement new 
		text: text;
		yourself.
		
	^ aView explicit
		title: 'Graphical';
		stencil: [ 
			BlElement new
				size: 338@213; "standard dimensions are 3.375 inches by 2.125 inches"
				background: Color veryLightGray;
				layout: BlLinearLayout horizontal alignCenter;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
				addChild: textElement;
				yourself ]
]

{ #category : #testing }
VsCreditCardAccount >> isPaymentTypeFor: aString [ 

	^ aString endsWith: self lastFour asString
]

{ #category : #accessing }
VsCreditCardAccount >> lastFour [

	^ self number asString last: 4
]

{ #category : #printing }
VsCreditCardAccount >> printOn: aStream [

	aStream nextPutAll: name.
	self number ifNotNil: [ 
		aStream 
			nextPutAll: ' (... ';
			nextPutAll: self lastFour;
			nextPut: $) ]
]

{ #category : #accessing }
VsCreditCardAccount >> rootFolder [
	^ FileLocator virtualStashData / 'Accounts' / self name
]

{ #category : #accessing }
VsCreditCardAccount >> statements [
	| files year monthOrDay parser |
	year := (#digit asPParser min: 4 max: 4) flatten ==> #asNumber.
monthOrDay := (#digit asPParser min: 2 max: 2) flatten ==> #asNumber.
parser := year, $- asPParser optional, monthOrDay, $- asPParser optional, monthOrDay optional ==> [ :nodes | 
	| day |
	day := nodes fifth ifNil: [ 1 ].
	Date year: nodes first month: nodes third day: day ].

	files := self rootFolder / 'Statements' filesMatching: '*.pdf'.
	^ files
		collect: [ :e | 
			| statement dateParts |
			statement := VsStatement fromResourceable: e.
			"The filename convention is e.g. 2020-11-30... with dashes and day optional"
			dateParts := e base splitOn: $-.
			statement closingDate: (parser parse: e base).
			statement ]
		as: SortedCollection
]
