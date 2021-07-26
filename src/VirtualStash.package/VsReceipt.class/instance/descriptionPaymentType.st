magritte
descriptionPaymentType
	<magritteDescription>
	
    ^ MASingleOptionDescription new
        accessor: #paymentType;
        label: 'Payment Type';
		options: VsPaymentType all;
		display: [ :e | e name ];
		beRequired;
        priority: 100;
        yourself