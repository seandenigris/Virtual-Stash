accessing
journalLines
	^ OrderedCollection new
		add: self;
		addAll: self splits;
		collect: [ :e |
			VsJournalLine new 
				model: e;
				yourself ]