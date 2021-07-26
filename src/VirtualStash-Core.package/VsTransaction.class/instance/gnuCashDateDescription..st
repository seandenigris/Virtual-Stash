GnuCash
gnuCashDateDescription: aDescription
	<magritteDescription: #dateDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Date';
		yourself