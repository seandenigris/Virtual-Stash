magritte-accessing
numberDescription
	"Also called a 'reference number' e.g. in Quickbooks, or `reference` but we stick with the simplest term that conveys the meaning (also ==reference== could be confusing since we're heavily using Magritte"
	<magritteDescription>
	^ MAStringDescription new
		accessor: #number;
		priority: 200;
		yourself