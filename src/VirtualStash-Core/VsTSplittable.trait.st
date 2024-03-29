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
