Trait {
	#name : #VsTSplittable,
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #'magritte-accessing' }
VsTSplittable >> accountDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
			accessor: #account;
			label: 'Account';
			options: self accountSource accounts;
			priority: 400;
			yourself
]

{ #category : #'magritte-accessing' }
VsTSplittable >> amountToString: aNumber [
	| intString decimalString |
	intString := aNumber asInteger asStringWithCommas.
	decimalString := aNumber isInteger
		ifTrue: [ '00' ]
		ifFalse: [ (aNumber \\ 1 * 100) asInteger asString ].
	aNumber = 0
		ifTrue: [ '' ]
		ifFalse: [ intString , '.' , decimalString ]
]

{ #category : #'magritte-accessing' }
VsTSplittable >> creditAmountDescription [
	<magritteDescription>
	^ MAMoneyDescription vsNew
			accessor: #creditAmount;
			label: 'Credit';
			priority: 700;
			beRequired;
			yourself
]

{ #category : #'magritte-accessing' }
VsTSplittable >> debitAmountDescription [
	<magritteDescription>
	^ MAMoneyDescription vsNew
		accessor: #debitAmount;
		label: 'Debit';
		priority: 600;
		beRequired;
		yourself
]

{ #category : #'magritte-accessing' }
VsTSplittable >> gnuCashAccountDescription: aDescription [
	<magritteDescription: #accountDescription>
	^ aDescription
		csvFieldName: 'Full Account Name';
		csvReader: [ :s | 
			aDescription options detect: [ :accnt |
				accnt gnuCashAccountFullName = s ] ];
		yourself
]

{ #category : #'magritte-accessing' }
VsTSplittable >> gnuCashStatusDescription: aDescription [
	<magritteDescription: #statusDescription>
	^ aDescription
		csvFieldName: 'Reconcile';
		csvReader: [ :s | VsReconciliationStatus fromGnuCashCode: s ];
		yourself
]

{ #category : #'magritte-accessing' }
VsTSplittable >> statusDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
			accessor: #status;
			label: 'Status';
			options: VsReconciliationStatus all;
			default: VsUnreconciled new;
			priority: 500;
			display: #gnuCashCode;
			yourself
]
