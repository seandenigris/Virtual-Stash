accessing
buildSaveButton
	^ BrButton new
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude"
		FLAG: spike to have ability to confirm changes before accepting
		 new + (BrGlamorousWithDropdownAptitude
			handle: [
				BrButton new
					icon: BrGlamorousIcons empty;
					beSmallSize;
					aptitude: BrGlamorousButtonRectangularAptitude new + BrGlamorousButtonIconAptitude new ]
			content: [
				BlLazyElement new
					layout: BlLinearLayout vertical;
					withGlamorousPreview: 'Computing...';
					constraintsDo: [ :c |
						c vertical exact: 50.
						c horizontal exact: 500 ];
					postAction: [ :theLazyElement |								
						theLazyElement constraintsDo: [ :c | 
							c vertical fitContentLimited ] ];
					elementBuilder: [ self buildChangesPreview ] ])";
		label: 'Save';
		icon: BrGlamorousVectorIcons accept;
		action: [ 
			self save.
			self phlow spawnObject: self counterparty ];
		yourself.