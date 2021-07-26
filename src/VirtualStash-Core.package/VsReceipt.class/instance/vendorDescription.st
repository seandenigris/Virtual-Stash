magritte
vendorDescription
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #vendor;
			label: 'Vendor';
			display: [ :e | e name ];
			options: MpAddressBook default contacts;
			priority: 400;
			beRequired;
			yourself