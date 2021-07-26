magritte-accessing
isPlaceholderDescription
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isPlaceholder;
		comment:
			'Account will be read-only; transactions can''t be directly added. Useful for structuring the chart of accounts.';
		default: false;
		csvFieldName: 'placeholder';
		csvReader: [ :str | str = 'T' ];
		yourself