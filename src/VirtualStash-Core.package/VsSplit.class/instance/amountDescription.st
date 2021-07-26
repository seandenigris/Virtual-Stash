magritte-accessing
amountDescription
	<magritteDescription>
	^ MAMoneyDescription new
			accessor: #amount;
			label: 'Amount';
			"display: [ :e | '$' , e asString ];"
			priority: 200;
			beRequired;
			yourself