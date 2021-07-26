GnuCash
gnuCashIDDescription
	<magritteDescription>
	^ MAStringDescription new
		accessor: #gnuCashID;
		propertyAt: #csvFieldName put: 'Transaction ID';
		yourself