"
```smalltalk
| receipt |
receipt := self new asMagritteMorph.
receipt
	addWindow;
	openInWorld.
```
# Creation
## Bulk
A common scenario is that you have a bunch of files that you want to turn into receipts. There are two options:
1. If you have a folder full of JPEGs, you can pass them to {{gtMethod:VsReceipt class>>#fromImagesIn:}}
2. For more control, you can create a collection of receipt files and pass them to {{gtMethod:VsReceipt class>>#fromFiles:}}

"
Class {
	#name : #VsReceipt,
	#superclass : #VsDocument,
	#instVars : [
		'vendor',
		'date',
		'amount',
		'paymentMethod'
	],
	#category : #'VirtualStash-Core-Receipts'
}

{ #category : #accessing }
VsReceipt class >> exampleCash [
	<gtExample>
	^ self new
		resource: (FileLocator virtualStashData / 'Examples' / 'Receipt_20151230_0004.pdf') asRlResource;
		yourself
]

{ #category : #accessing }
VsReceipt >> amount [
	^ amount
]

{ #category : #accessing }
VsReceipt >> amount: anObject [
	amount := anObject
]

{ #category : #magritte }
VsReceipt >> amountDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #amount;
		label: 'Amount';
		display: [ :e | '$' , e asString ];
		priority: 200;
		beRequired;
		propertyAt: #shortcut put: #a;
		propertyAt: #whitelist put: '$1234567890#.';
		yourself
]

{ #category : #converting }
VsReceipt >> asMorph [

	^ VsReceiptImageUI on: self.
]

{ #category : #'as yet unclassified' }
VsReceipt >> beCash [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
VsReceipt >> beNonReceipt [
	self error: 'no longer one file. one per book'.
	self flag: 'This is obviously not a good solution, but I have no idea how VS will integrate with other systems, so hack this in to get non-receipts out of the way for now'.
	VsReceiptFile uniqueInstance receipts remove: self.
	VsReceiptFile uniqueInstance nonReceipts add: self.
]

{ #category : #magritte }
VsReceipt >> beNonReceiptDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		action: #beNonReceipt;
		label: 'Not a receipt';
		priority: 200;
		yourself
]

{ #category : #transactions }
VsReceipt >> businessTransaction [
	^ VsBooks business generalJournal transactions
			detect: [ :e | e receipt == self ]
			ifNone: [ nil ]
]

{ #category : #transactions }
VsReceipt >> businessTransaction: transaction [
	transaction ifNil: [ ^ self ].
	transaction receipt: self.
	VsBooks business generalJournal add: transaction
]

{ #category : #magritte }
VsReceipt >> businessTransactionDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #businessTransaction;
			label: 'Bus. Trans.';
			classes: { VsTransaction };
			initializer: [ :e | self initializeTransaction: e in: VsBooks business ];
			priority: 500;
			yourself
]

{ #category : #accessing }
VsReceipt >> date [
	^ date
]

{ #category : #accessing }
VsReceipt >> date: anObject [
	date := anObject
]

{ #category : #magritte }
VsReceipt >> dateDescription [
	<magritteDescription>
	^ MADateDescription new
			accessor: #date;
			label: 'Date';
			display: [ :e | e monthName , ' ' , e dayOfMonth asString , ', ' , e year asString ];
			beRequired;
			default: Date today;
			priority: 100;
			propertyAt: #shortcut put:#d;
			yourself
]

{ #category : #'as yet unclassified' }
VsReceipt >> enterAsPersonal [

	VsGeneralJournal uniqueInstance addEntryFromReceipt: self
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessDate [

	| candidates |
	candidates := self possibleDates.
	candidates size = 0 ifTrue: [ ^ nil ].
	^ candidates atRandom
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessPaymentType [

	^ VsPaymentMethod all detect: [ :card | self hocr words anySatisfy: [ :token | token string matchesRegex: '.*x+', card lastFour asString ] ].
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessTotal [

	| possibilities bestGuess suggestions rankedGuesses optionalDollarSign oneOrMoreDigits moneyRegex |
	optionalDollarSign := '\$?'.
	oneOrMoreDigits := '\d+'.
	moneyRegex := optionalDollarSign, oneOrMoreDigits, '\.\d\d'.
	possibilities := self hocr words select: [ :e | e string matchesRegex: moneyRegex ].
	possibilities := possibilities asOrderedCollection.
	rankedGuesses := possibilities sort: [ :a :b | | aNumeric bNumeric |
		aNumeric := a string copyWithout: $$.
		bNumeric := b string copyWithout: $$.
		aNumeric asNumber > bNumeric asNumber ].
	bestGuess := rankedGuesses first.
	suggestions := VsReceiptFieldSuggestions on: possibilities.
	^ suggestions
		bestGuess: bestGuess;
		yourself.
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessVendor [

	^ self hocr words detect: [ :e | e string = 'H&M' ] ifNone: [ '?' ].
]

{ #category : #magritte }
VsReceipt >> initializeTransaction: transaction in: books [

	| entry |
	entry := VsSplit new
		account: self paymentMethod;
		amount: self amount;
		accountSource: books.
	transaction
		date: self date;
		counterparty: self vendor;
		receipt: self;
		accountSource: books.
	transaction entries add: entry
]

{ #category : #accessing }
VsReceipt >> paymentMethod [
	^ paymentMethod
]

{ #category : #accessing }
VsReceipt >> paymentMethod: anObject [
	paymentMethod := anObject
]

{ #category : #magritte }
VsReceipt >> paymentMethodDescription [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #paymentMethod;
		label: 'Payment Method';
		options: VsPaymentMethod all;
		display: #name;
		beRequired;
		priority: 300;
		propertyAt: #shortcut put: #p;
		yourself
]

{ #category : #transactions }
VsReceipt >> personalTransaction [
	^ VsBooks personal generalJournal transactions
			detect: [ :e | e receipt == self ]
			ifNone: [ nil ]
]

{ #category : #transactions }
VsReceipt >> personalTransaction: transaction [
	transaction ifNil: [ ^ self ].
	transaction receipt: self.
	VsBooks personal generalJournal add: transaction
]

{ #category : #magritte }
VsReceipt >> personalTransactionDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #personalTransaction;
			label: 'Personal Trans.';
			classes: { VsTransaction };
			initializer: [ :e | self initializeTransaction: e in: VsBooks personal ];
			priority: 600;
			yourself
]

{ #category : #accessing }
VsReceipt >> possibleDates [
	^ self resource possibleDates.
]

{ #category : #'as yet unclassified' }
VsReceipt >> possibleVendors [

	^ MpRelatableEntity for: self
]

{ #category : #printing }
VsReceipt >> printOn: aStream [

	super printOn: aStream.
	vendor ifNotNil: [ aStream nextPutAll: self vendor name ].
	amount ifNotNil: [ aStream space; print: self amount ].
	date ifNotNil: [ aStream nextPutAll: ' on '; nextPutAll: self date mmddyyyy ].
	paymentMethod ifNotNil: [ aStream nextPutAll: ' with '; print: self paymentMethod ].
]

{ #category : #actions }
VsReceipt >> submit [
	self shouldBeImplemented.
]

{ #category : #magritte }
VsReceipt >> submitDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		action: #submit;
		label: 'Submit';
		priority: 100;
		yourself
]

{ #category : #accessing }
VsReceipt >> vendor [
	^ vendor
]

{ #category : #accessing }
VsReceipt >> vendor: anObject [
	vendor := anObject
]

{ #category : #magritte }
VsReceipt >> vendorDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #vendor;
			priority: 400;
			gtSearchSource: (MessageSend receiver: MpAddressBook selector: #uniqueInstance);
			beRequired;
			yourself
]
