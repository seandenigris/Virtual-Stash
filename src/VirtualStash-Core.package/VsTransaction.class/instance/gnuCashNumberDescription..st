GnuCash
gnuCashNumberDescription: aDescription
	<magritteDescription: #numberDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Transaction Number';
		yourself