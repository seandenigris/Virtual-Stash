magritte-accessing
issuerDescription
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #issuer;
		extensible: true;
		options: MpAddressBook default contacts;
		yourself