magritte-accessing
amountDescription
	"<magritteDescription>"
	^ MANumberDescription new
		accessor: #amount;
		display: [ :e | '$' , e asString ];
		priority: 500;
		beReadOnly;
		yourself