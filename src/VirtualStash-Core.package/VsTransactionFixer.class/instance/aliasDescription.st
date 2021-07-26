magritte-accessing
aliasDescription
	<magritteDescription>
	^ MAStringDescription new
		accessor: #alias;
		default: (self parser parse: self input) first;
		shouldCacheDefault: true;
		yourself