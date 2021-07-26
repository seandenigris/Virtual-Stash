initialization
initializeSummary

	summary
		"items: VsBooks uniqueInstance expenses;"
		displayBlock: [ :e | 
			{ 
				e accountName.
				e balance printShowingDecimalPlaces: 2 } ].