Trait {
	#name : 'VsTSplittable',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'magritte-accessing' }
VsTSplittable >> accountDescription [
	<magritteDescription>

	^ MAToOneRelationDescription new
		accessor: #account;
		gtSearchSource: [ :anObject | anObject accountSource ];
		classes: VsAccount allSubclasses;
		priority: 400;
		yourself
]

{ #category : 'magritte-accessing' }
VsTSplittable >> creditAmountDescription [
	<magritteDescription>
	^ MAMoneyDescription vsNew
		accessor: #creditAmount;
		label: 'Credit';
		priority: 700;
		beRequired;
		yourself
]

{ #category : 'magritte-accessing' }
VsTSplittable >> debitAmountDescription [
	<magritteDescription>
	^ MAMoneyDescription vsNew
		accessor: #debitAmount;
		label: 'Debit';
		priority: 600;
		beRequired;
		yourself
]

{ #category : 'magritte-accessing' }
VsTSplittable >> statusDescription [
	<magritteDescription>

	^ MASingleOptionDescription new
		accessor: #status;
		options: VsReconciliationStatus all;
		default: VsUnreconciled new;
		priority: 500;
		display: #gnuCashCode;
		yourself
]
