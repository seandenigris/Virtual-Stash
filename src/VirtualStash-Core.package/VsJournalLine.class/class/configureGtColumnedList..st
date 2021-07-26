accessing
configureGtColumnedList: list
	self new magritteDescription do: [ :e |
		list 
			column: e label
			text: [ :line | line fieldStringUsing: e ]
			weight: e vsColumnWeight ]