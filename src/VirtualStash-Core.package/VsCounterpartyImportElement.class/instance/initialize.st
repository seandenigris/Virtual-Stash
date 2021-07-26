accessing
initialize
	| formElement toolbar saveButton wwwButton |
	
	super initialize.
	
	self
		vFitContent;
		hMatchParent.
	
	formElement := BlElement new
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ];
		layout:
			(BlGridLayout horizontal
				columnCount: 2;
				cellSpacing: 10).
				
	editorInputElement := BrEditor new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousInputFieldSpacingAptitude new + BrGlamorousRegularEditorAptitude new;
				text: ''.
				
	memoInputElement := BrEditor new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousInputFieldSpacingAptitude new + BrGlamorousRegularEditorAptitude new;
				text: ''.
				
	paymentProcessorInputElement := BrLabel new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousLabelAptitude;
				text: ''.
				
	self inputElement: editorInputElement named: 'New' in: formElement.
	self inputElement: memoInputElement named: 'Memo' in: formElement.
	self inputElement: paymentProcessorInputElement named: 'POS' in: formElement.
	self inputElement: self matchList named: 'Contacts' in: formElement.
		
	toolbar := BrToolbar new
		aptitude: BrToolbarAptitude new;
		layout:
			(BlGridLayout horizontal
				rowCount: 1;
				cellSpacing: 10);
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
			
	wwwButton := BrButton new
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'WWW Search';
		icon: BrGlamorousVectorIcons search;
		action: [ self transactionGroup searchWWW ];
		yourself.
		
	saveButton := self buildSaveButton.
		
	toolbar 
		addItem: wwwButton;
		addItem: saveButton.
	
	self addChild: formElement.
	self addChild: toolbar.
	
	matchList when: BrSelectionChanged do: [ :anEvent | 
	anEvent selectedInterval isEmptyOrNil
		ifTrue: [ editorInputElement text: self transactionGroup input suggestion ]
		ifFalse: [ 
			| item |
			item := matchList items at: anEvent selectedInterval anyOne.
			editorInputElement text: item first ] ].