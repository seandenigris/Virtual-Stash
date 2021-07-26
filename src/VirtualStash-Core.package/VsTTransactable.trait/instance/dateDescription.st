magritte-accessing
dateDescription
	<magritteDescription>

	^ MADateDescription new
			accessor: #date;
			display: #mmddyyyy;
			beRequired;
			priority: 100;
			yourself