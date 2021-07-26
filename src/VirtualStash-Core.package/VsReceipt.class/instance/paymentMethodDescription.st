magritte
paymentMethodDescription
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #paymentMethod;
		label: 'Payment Method';
		options: VsPaymentMethod all;
		display: #name;
		beRequired;
		priority: 300;
		propertyAt: #shortcut put: #p;
		yourself