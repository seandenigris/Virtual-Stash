accessing
spec
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
				newRow: [ :spec | spec "add: #previousMonthButton; add: #nextMonthButton;" add: #month; add: #year ] height: 30;
				newRow: [ :spec | spec add: #summary ];
				newRow: [ :spec | spec add: #list ];
				newRow: [ :spec | spec add: #addButton ] height: 30 ];
			yourself.