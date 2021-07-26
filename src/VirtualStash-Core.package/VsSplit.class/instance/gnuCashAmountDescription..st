magritte-accessing
gnuCashAmountDescription: aDescription
	<magritteDescription: #amountDescription>
	^ aDescription
		csvFieldName: 'Amount Num.';
		csvReader: [ :str | str vsAsUSD ];
		yourself