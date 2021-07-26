GnuCash
gnuCashVoidReasonDescription: aDescription
	<magritteDescription: #voidReasonDescription>
	^ aDescription
		propertyAt: #csvFieldName put: 'Void Reason';
		yourself