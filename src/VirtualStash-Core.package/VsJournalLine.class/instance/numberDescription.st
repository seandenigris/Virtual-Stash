magritte-accessing
numberDescription
	"Also called a 'reference number' e.g. in Quickbooks, but we stick with the simplest term that conveys the meaning"
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		priority: 200;
		propertyAt: #vsColumnWeight put: 0.1;
		yourself