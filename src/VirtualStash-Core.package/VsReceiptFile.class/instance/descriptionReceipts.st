magritte
descriptionReceipts
	<magritteDescription>
	<gtInspectorPresentationOrder: 2>
	^ MAToManyRelationDescription new
		accessor: #receipts;
		label: 'Receipts';
		classes: {VsReceipt};
		glmPresentation: #list;
		priority: 100;
		beRequired;
		yourself