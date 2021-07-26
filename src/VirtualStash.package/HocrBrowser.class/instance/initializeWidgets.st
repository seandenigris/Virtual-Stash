initialization
initializeWidgets

	self instantiateModels: #(
		list ListModel).
	
	list displayBlock: [ :e | e string ].	
	"e.g. loadButton
		label: 'Load';
		action: [ self project load ];
		enabled: false."