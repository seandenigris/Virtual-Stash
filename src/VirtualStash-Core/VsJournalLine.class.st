Class {
	#name : #VsJournalLine,
	#superclass : #Object,
	#traits : 'VsTTransactable - {#counterpartyDescription} + VsTSplittable',
	#classTraits : 'VsTTransactable classTrait + VsTSplittable classTrait',
	#instVars : [
		'model'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsJournalLine class >> configureGtColumnedList: list [
	self new magritteDescription do: [ :e |
		list 
			column: e label
			text: [ :line | line fieldStringUsing: e ]
			weight: e vsColumnWeight ]
]

{ #category : #accessing }
VsJournalLine >> accountSource [
	^ self model ifNotNil: [ :m | m accountSource ]
]

{ #category : #'magritte-accessing' }
VsJournalLine >> amountDescription: aDescription [
	<magritteDescription: #creditAmountDescription>
	<magritteDescription: #debitAmountDescription>
	^ aDescription
		display: [ :e | e amount printShowingDecimalPlaces: 2 ];
		yourself
]

{ #category : #'magritte-accessing' }
VsJournalLine >> amountToString: aNumber [
	| intString decimalString |
	intString := aNumber asInteger asStringWithCommas.
	decimalString := aNumber isInteger
		ifTrue: [ '00' ]
		ifFalse: [ (aNumber \\ 1 * 100) asInteger printPaddedWith: $0 to: 2  ].
	^ aNumber = 0
		ifTrue: [ '' ]
		ifFalse: [ intString , '.' , decimalString ]
]

{ #category : #'magritte-accessing' }
VsJournalLine >> columnThreeDescription [
	<magritteDescription>
	^ self model journalColumnThreeDescription
]

{ #category : #'magritte-accessing' }
VsJournalLine >> doesNotUnderstand: aMessage [
	^ (self model isNotNil and: [ self model respondsTo: aMessage selector ]) 
		ifTrue: [ aMessage sendTo: self model ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : #accessing }
VsJournalLine >> fieldStringUsing: aDescription [
	^ (self model magritteDescription includes: aDescription)
		ifTrue: [ aDescription readToString: self model ]
		ifFalse: [ '' ]
]

{ #category : #accessing }
VsJournalLine >> model [
	^ model ifNil: [ VsSplit new ]
]

{ #category : #accessing }
VsJournalLine >> model: anObject [
	model := anObject
]

{ #category : #'magritte-accessing' }
VsJournalLine >> numberDescription [
	"Also called a 'reference number' e.g. in Quickbooks, but we stick with the simplest term that conveys the meaning"
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		priority: 200;
		propertyAt: #vsColumnWeight put: 0.1;
		yourself
]

{ #category : #'magritte-accessing' }
VsJournalLine >> statusDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
			accessor: #status;
			label: 'Status';
			options: VsReconciliationStatus all;
			default: VsUnreconciled new;
			priority: 500;
			display: #gnuCashCode;
			propertyAt: #vsColumnWeight put: 0.05;
			yourself
]

{ #category : #'magritte-accessing' }
VsJournalLine >> undefinedValue [
	^ nil
]
