accessing
spec
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
				newRow: [ :spec | spec add: #list ];
				newRow: [ :spec | spec add: #addButton ] height: 30 ];
			yourself.