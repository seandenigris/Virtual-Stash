magritte-accessing
debitAmountDescription
	<magritteDescription>
	^ MAMoneyDescription new
		accessor: #debitAmount;
		label: 'Debit';
		priority: 600;
		beRequired;
		yourself