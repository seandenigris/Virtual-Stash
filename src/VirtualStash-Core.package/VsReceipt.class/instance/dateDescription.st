magritte
dateDescription
	<magritteDescription>
	^ MADateDescription new
			accessor: #date;
			label: 'Date';
			display: [ :e | e monthName , ' ' , e dayOfMonth asString , ', ' , e year asString ];
			beRequired;
			default: Date today;
			priority: 100;
			propertyAt: #shortcut put:#d;
			yourself