GnuCash
gnuCashMemoDescription: aDescription
	<magritteDescription: #memoDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Notes';
		yourself