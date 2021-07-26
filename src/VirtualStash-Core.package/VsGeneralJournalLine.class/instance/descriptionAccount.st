as yet unclassified
descriptionAccount
	<magritteDescription>
	^ MAOptionDescription new
        accessor: #account;
        label: 'Account';
		classes: { VsAccount };
        priority: 100;
		beRequired;
        yourself