magritte-accessing
gnuCashStatusDescription: aDescription
	<magritteDescription: #statusDescription>
	^ aDescription
		csvFieldName: 'Reconcile';
		csvReader: [ :s | VsReconciliationStatus fromGnuCashCode: s ];
		yourself