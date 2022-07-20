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
	#superclass : #Object,
	#instVars : [
		'resource',
		'ocr',
		'hocr',
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

{ #category : #'as yet unclassified' }
VsReceipt class >> fromFiles: files [

	^ files collect: [ :e | 
			self new
				importFile: e;
				yourself ].
]

{ #category : #'as yet unclassified' }
VsReceipt class >> fromImagesIn: directory [

	| images |
	images := directory filesMatching: '*.jpg'.
	^ self fromFiles: images
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

{ #category : #accessing }
VsReceipt >> asElement [
	^ RlHOCRElement new
		client: self;
		yourself.
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

{ #category : #accessing }
VsReceipt >> form [
	^ self imageFile
		ifNotNil: [ :f | Form fromFileNamed: f fullName ]
		ifNil: [ Morph new imageForm ]
]

{ #category : #accessing }
VsReceipt >> gtFigureFor: aView [
    <gtView>
    ^ aView pannable
        title: 'Figure';
        priority: 1;
        stencil: [ self asElement ]
]

{ #category : #accessing }
VsReceipt >> gtHocrFor: aView [
	<gtView>
	^ aView forward
		title: 'hOCR';
		priority: 2;
		object: [ self hocr ];
		view: #gtLinesFor:
]

{ #category : #GT }
VsReceipt >> gtInspectorDomainIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite table
		title: 'Receipt';
		display: [
				self magritteDescription children collect: [ :desc |
					desc label -> (desc accessor read: self) ] ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]

{ #category : #GT }
VsReceipt >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ composite morph 
		title: 'Morph';
		display: [ self asMorph ]
]

{ #category : #accessing }
VsReceipt >> gtOCRFor: aView [
	<gtView>
	^ aView text
		priority: 3;
		title: 'OCR';
		text: [ self ocr ]
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessDate [

	^ self resource possibleDates.
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessPaymentType [

	^ VsPaymentMethod all detect: [ :card | hocr words anySatisfy: [ :token | token string matchesRegex: '.*x+', card lastFour asString ] ].
]

{ #category : #'ocr-guessing' }
VsReceipt >> guessTotal [

	| possibilities bestGuess suggestions rankedGuesses optionalDollarSign oneOrMoreDigits moneyRegex |
	optionalDollarSign := '\$?'.
	oneOrMoreDigits := '\d+'.
	moneyRegex := optionalDollarSign, oneOrMoreDigits, '\.\d\d'.
	possibilities := hocr words select: [ :e | e string matchesRegex: moneyRegex ].
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

	^ hocr words detect: [ :e | e string = 'H&M' ] ifNone: [ '?' ].
]

{ #category : #ocr }
VsReceipt >> hocr [

	^ hocr ifNil: [ hocr := self resource hocr ].
]

{ #category : #printing }
VsReceipt >> hocrLineFrom: xmlNode [

	^ ReceiptHocrLine on: xmlNode for: self
]

{ #category : #accessing }
VsReceipt >> imageFile [

	^ self resource imageFile
]

{ #category : #accessing }
VsReceipt >> imageFolder [

	^ FileLocator dynabookData / 'Virtual Stash' / 'Inbox'
]

{ #category : #accessing }
VsReceipt >> importFile: file [
	self resource: file asRlResource import
]

{ #category : #testing }
VsReceipt >> includesSubstring: aString [ 
	"Case-insensitive"

	^ self hocr lines anySatisfy: [ :line | line string asLowercase includesSubstring: aString asLowercase ]
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

{ #category : #ocr }
VsReceipt >> newHocrFrom: aString [

	^ ReceiptHocr on: aString for: self
]

{ #category : #ocr }
VsReceipt >> ocr [

	^ ocr ifNil: [ ocr := self resource ocr ].
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
	^ self hocr words 
		inject: Set new 
		into: [ :set :word | 
			[ set add: word string asDate ] 
				onErrorDo: [ ].
			set ]
]

{ #category : #'as yet unclassified' }
VsReceipt >> possibleVendors [

	^ MpRelatableEntity for: self
]

{ #category : #printing }
VsReceipt >> printOn: aStream [

	vendor ifNotNil: [ aStream nextPutAll: self vendor name ].
	amount ifNotNil: [ aStream space; print: self amount ].
	date ifNotNil: [ aStream nextPutAll: ' on '; nextPutAll: self date mmddyyyy ].
	paymentMethod ifNotNil: [ aStream nextPutAll: ' with '; print: self paymentMethod ].
]

{ #category : #accessing }
VsReceipt >> resource [
	^ resource
]

{ #category : #accessing }
VsReceipt >> resource: anObject [
	resource := anObject
]

{ #category : #accessing }
VsReceipt >> rotate [
	self resource rotate
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

{ #category : #ocr }
VsReceipt >> tesseractInputFile [

	^ self resource tesseractInputFile
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
	^ MASingleOptionDescription new
			accessor: #vendor;
			label: 'Vendor';
			display: [ :e | e name ];
			options: MpAddressBook default contacts;
			priority: 400;
			beRequired;
			yourself
]

{ #category : #testing }
VsReceipt >> wants_hOCR [
	^ true
]
