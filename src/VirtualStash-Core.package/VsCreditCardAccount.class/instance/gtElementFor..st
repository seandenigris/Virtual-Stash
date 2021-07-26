accessing
gtElementFor: aView
	<gtView>
	| textElement text |
	text := ('**** **** **** ', self lastFour asString) asRopedText
		fontSize: 24;
		fontName: 'Courier';
		yourself.
		
	textElement := BlTextElement new 
		text: text;
		yourself.
		
	^ aView explicit
		title: 'Graphical';
		stencil: [ 
			BlElement new
				size: 338@213; "standard dimensions are 3.375 inches by 2.125 inches"
				background: Color veryLightGray;
				layout: BlLinearLayout horizontal alignCenter;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
				addChild: textElement;
				yourself ]