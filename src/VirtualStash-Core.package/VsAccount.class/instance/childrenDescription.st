magritte-accessing
childrenDescription
	<magritteDescription>
	<gtInspectorPresentationOrder: 10>
	^ MAToManyRelationDescription new
			accessor: #children;
			label: 'Children';
			glmPresentation: #list;
			yourself