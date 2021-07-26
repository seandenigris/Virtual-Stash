magritte-accessing
accountsDescription
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #accounts;
		default: OrderedCollection new;
		yourself