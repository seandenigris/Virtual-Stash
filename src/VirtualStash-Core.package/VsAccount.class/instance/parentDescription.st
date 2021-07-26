magritte-accessing
parentDescription
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #parent;
		extensible: true;
		options: #();
		csvFieldName: #full_name;
		csvReader: [ :str | 
			(str includesSubstring: ':')
				ifTrue: [ str copyUpToLast: $: ] ];
		yourself