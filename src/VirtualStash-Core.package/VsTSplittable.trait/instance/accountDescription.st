magritte-accessing
accountDescription
	<magritteDescription>

	^ MASingleOptionDescription new
			accessor: #account;
			label: 'Account';
			options: self accountSource accounts;
			priority: 400;
			yourself