magritte-accessing
amountDescription: aDescription
	<magritteDescription: #creditAmountDescription>
	<magritteDescription: #debitAmountDescription>
	^ aDescription
		display: [ :e | e amount printShowingDecimalPlaces: 2 ];
		yourself