magritte-accessing
creditAmountDescription
	<magritteDescription>
	^ MAMoneyDescription new
			accessor: #creditAmount;
			label: 'Credit';
			priority: 700;
			beRequired;
			yourself