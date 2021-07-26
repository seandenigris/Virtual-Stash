accessing
spec
	<spec: #default>

	^ SpecLayout composed
			newColumn: [ :col | col
			newRow: [ :spec | spec add: #date ] height: 30;
			newRow: [ :spec | spec add: #accountLabel; add: #account ] height: 30;
			newRow: [ :spec | spec add: #descriptionLabel; add: #description ] height: 30;
			newRow: [ :spec | spec add: #amountLabel; add: #amount ] height: 30 ];
			yourself.