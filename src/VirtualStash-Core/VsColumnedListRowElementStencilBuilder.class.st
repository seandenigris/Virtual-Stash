Class {
	#name : #VsColumnedListRowElementStencilBuilder,
	#superclass : #BrGlamorousColumnedListSelectableRowElementStencilBuilder,
	#category : #'VirtualStash-Core'
}

{ #category : #accessing }
VsColumnedListRowElementStencilBuilder >> buildDefault [

	| bar row selectedStyler editorStencil labelStencil deselectedStyler |
	bar := BlElement new
		"visibility: BlVisibility hidden;"
		background: Color veryLightGray;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored vertical alignBottom.
			c vertical exact: 1.
			c horizontal matchParent ].
			
	row := super buildDefault.
	
	editorStencil := [ :tx |
	BrEditor new
		aptitude: "BrGlamorousEditorAptitude +" BrGlamorousEditableLabelAptitude + BrGlamorousInputFieldSpacingAptitude;
		margin: (BlInsets all: 5);
		text: tx date mmddyyyy;
		hMatchParent;
		vFitContent ].
		
	labelStencil := [ :tx |
	BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		margin: (BlInsets all: 5);
		text: tx date mmddyyyy;
		hMatchParent";
		vExact: 50" ].
	
	selectedStyler := [ :styler |
		| inputElems |
		
		UIManager default inform: 'select'.
		inputElems := row allChildrenBreadthFirstSelect: [ :elem | elem userData includesKey: #transaction ].
		inputElems do: [ :inputElem |
			inputElem 
				removeChildren;
				addChild: (editorStencil value: (inputElem userData at: #transaction)).
			] ].
			
	deselectedStyler := [ :styler |
		| inputElems |
		
		UIManager default inform: 'deselect'.
		inputElems := row allChildrenBreadthFirstSelect: [ :elem | elem userData includesKey: #transaction ].
		inputElems do: [ :inputElem |
			inputElem 
				removeChildren;
				addChild: (labelStencil value: (inputElem userData at: #transaction)).
			] ].
		
	^ row
		addChild: bar;
		addAptitude: (BrLazyStyleCommonAptitude new
				when: BlElementState selected
					style: selectedStyler);
		addAptitude: (BrLazyStyleCommonAptitude new
				when: BlElementState deselected
					style: deselectedStyler);
		yourself
]
