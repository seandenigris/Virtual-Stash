accessing
initialize
	super initialize.
	self
			layout: (BlLinearLayout horizontal cellSpacing: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude) as: #label;
			addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonWithLabelAptitude;
				action: [ self target applyRule: self rule ];
				label: 'Apply') as: #button