magritte-accessing
statusDescription
	<magritteDescription>

	^ MASingleOptionDescription new
			accessor: #status;
			label: 'Status';
			options: VsReconciliationStatus all;
			default: VsUnreconciled new;
			priority: 500;
			display: #gnuCashCode;
			yourself