GnuCash
commodityDescription
	<magritteDescription>
	^ MAStringDescription new
		accessor: #commodity;
		default: 'CURRENCY::USD';
		propertyAt: #csvFieldName put: 'Commodity/Currency';
		yourself