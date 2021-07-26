magritte
personalTransactionDescription
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #personalTransaction;
			label: 'Personal Trans.';
			classes: { VsTransaction };
			initializer: [ :e | self initializeTransaction: e in: VsBooks personal ];
			priority: 600;
			yourself