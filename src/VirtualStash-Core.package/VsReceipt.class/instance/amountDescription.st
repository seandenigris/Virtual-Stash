magritte
amountDescription
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