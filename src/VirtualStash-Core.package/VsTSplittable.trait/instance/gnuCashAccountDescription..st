magritte-accessing
gnuCashAccountDescription: aDescription
	<magritteDescription: #accountDescription>
	^ aDescription
		csvFieldName: 'Full Account Name';
		csvReader: [ :s | 
			aDescription options detect: [ :accnt |
				accnt gnuCashAccountFullName = s ] ];
		yourself