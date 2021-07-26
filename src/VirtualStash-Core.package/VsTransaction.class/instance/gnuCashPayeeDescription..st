GnuCash
gnuCashPayeeDescription: aDescription
	<magritteDescription: #counterpartyDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Description';
		yourself