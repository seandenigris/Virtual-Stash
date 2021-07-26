magritte-accessing
receiptDescription
	<magritteDescription>
	^ MAToOneRelationDescription new
			accessor: #receipt;
			classes: { VsReceipt };
			priority: 700;
			yourself