magritte-accessing
accountsDescription
	"Used by e.g. ==#printRegister:== to select relevant transactions"
	^ MAMultipleOptionDescription new
		accessor: #accounts;
		beReadonly;
		comment: 'a.k.a. Category, which seems more aimed at the casual user, rather than accounting industry standard';
		yourself