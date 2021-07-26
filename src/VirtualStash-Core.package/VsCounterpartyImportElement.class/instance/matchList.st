accessing
matchList
	matchList := BrColumnedList new
		hMatchParent;
		vExact: 200;
		rowStencil: (BrGlamorousColumnedListSelectableRowElementStencilBuilder new);
		yourself.
		
	matchList 
		addChild: (BrResizer new
			target: matchList;
			beBottom;
			aptitude: BrGlamorousResizerAptitude;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal weight: 0.5 ]).
				
	matchList column
		width: 50;
		title: 'Index';
		cellStencil: [
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 5) ];
		dataBinder: [ :eachElement :eachItem :eachIndex | 
			eachElement text: eachIndex asString ].
			
	matchList column
		matchParent;
		title: 'Color';
		cellStencil: [
			BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				padding: (BlInsets all: 5) ];
		dataBinder: [ :eachElement :eachItem :eachIndex | 
			eachElement text: eachItem first asRopedText ].
	
	^ matchList