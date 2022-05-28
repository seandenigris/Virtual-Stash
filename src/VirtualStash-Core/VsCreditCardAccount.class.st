Class {
	#name : #VsCreditCardAccount,
	#superclass : #VsLiabilityAccount,
	#instVars : [
		'benefits'
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
	| files |
	files := self rootFolder / 'Statements' filesMatching: '*.pdf'.
	^ files
		collect: [ :e | 
			| statement dateParts |
			statement := VsStatement on: e.
			"The filename convention is e.g. 2020-11-30... with day optional"
			dateParts := e base splitOn: $-.
			dateParts size > 2
				ifTrue: [ | closingDate |
					closingDate := Date
						year: dateParts first asNumber
						month: dateParts second asNumber
						day: dateParts third asNumber.
					statement closingDate: closingDate ].
			statement ]
		as: SortedCollection
]
