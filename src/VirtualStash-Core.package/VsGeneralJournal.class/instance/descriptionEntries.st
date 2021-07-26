magritte
descriptionEntries
	<magritteDescription>
	^ MAToManyRelationDescription new
			accessor: #entries;
			label: 'Entries';
			display: [ :e | e size asString , ' entries' ];
			classes: {VsTransaction};
			priority: 100;
			beRequired;
			yourself