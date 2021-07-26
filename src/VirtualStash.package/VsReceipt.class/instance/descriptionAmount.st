magritte
descriptionAmount
	<magritteDescription>
	
    ^ MANumberDescription new
        accessor: #amount;
        label: 'Amount';
		display: [ :e | '$', e asString ];
        priority: 100;
		beRequired;
        yourself