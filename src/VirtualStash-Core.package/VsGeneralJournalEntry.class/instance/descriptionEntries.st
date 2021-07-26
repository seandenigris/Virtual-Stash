magritte
descriptionEntries
	<magritteDescription>
	^ MAToManyRelationDescription new
        accessor: #lines;
        label: 'Lines';
		display: [ :e | e size asString, ' lines' ];
		classes: { VsGeneralJournalLine };
        priority: 100;
		beRequired;
        yourself