magritte-accessing
processorDescription
	
	<magritteDescription>
	^ MASingleOptionDescription new
			accessor: #processor;
			options: MpAddressBook default organizations;
			priority: 550;
			yourself