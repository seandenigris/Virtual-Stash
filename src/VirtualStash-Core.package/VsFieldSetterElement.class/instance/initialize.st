accessing
initialize
	super initialize.
	
	checkbox := BrCheckbox new
		aptitude: BrGlamorousCheckboxAptitude;
		margin: (BlInsets top: 6);
		check;
		yourself.
		
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude + BrGlamorousInputFieldSpacingAptitude new;
		text: self setter, ' ', self argument asString;
		yourself.
		
	self
		hMatchParent;
		vFitContent;
		addChild: checkbox;
		addChild: label;
		yourself