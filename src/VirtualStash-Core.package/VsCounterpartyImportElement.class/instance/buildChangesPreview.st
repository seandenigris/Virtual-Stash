accessing
buildChangesPreview
	| result |
	self flag: 'experimental; unused'.
	result := BrVerticalPane new
		padding: (BlInsets all: 20);
				hMatchParent;
				vFitContent;
				alignCenter.
	^ result 
		addChild: BlElement new;
		addChild: BlElement new;
		yourself
		