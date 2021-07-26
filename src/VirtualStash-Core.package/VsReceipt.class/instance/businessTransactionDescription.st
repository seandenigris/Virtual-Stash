magritte
businessTransactionDescription
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #businessTransaction;
			label: 'Bus. Trans.';
			classes: { VsTransaction };
			initializer: [ :e | self initializeTransaction: e in: VsBooks business ];
			priority: 500;
			yourself