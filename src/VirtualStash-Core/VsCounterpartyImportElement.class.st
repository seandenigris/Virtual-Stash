Class {
	#name : #VsCounterpartyImportElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'transactionGroup',
		'editorInputElement',
		'matchList',
		'paymentProcessor',
		'paymentProcessorInputElement',
		'input',
		'memoInputElement'
	],
	#category : 'VirtualStash-Core-GToolkit'
}

{ #category : #accessing }
VsCounterpartyImportElement class >> example [
	<gtExample>
	^ self new
		transactionGroup: VsTransactionImportGroup example;
		yourself.
]

{ #category : #accessing }
VsCounterpartyImportElement >> buildChangesPreview [
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
		
]

{ #category : #accessing }
VsCounterpartyImportElement >> buildSaveButton [
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
]

{ #category : #accessing }
VsCounterpartyImportElement >> counterparty [
	^ self transactionGroup counterparty
]

{ #category : #accessing }
VsCounterpartyImportElement >> initialize [
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
]

{ #category : #accessing }
VsCounterpartyImportElement >> inputElement: anElement named: aString in: formElement [
	| labelElement text |
	labelElement := BrLabel new text: aString, ':'; aptitude: BrGlamorousLabelAptitude.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	
	formElement addChild: labelElement.
	formElement addChild: anElement.
	^ anElement
]

{ #category : #accessing }
VsCounterpartyImportElement >> inputString [
	^ self transactionGroup input counterpartyName
]

{ #category : #accessing }
VsCounterpartyImportElement >> matchList [
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
]

{ #category : #accessing }
VsCounterpartyImportElement >> paymentProcessor [
	^ self transactionGroup input paymentProcessor
]

{ #category : #accessing }
VsCounterpartyImportElement >> save [

	| newName message party |
	newName := matchList selectedIndices 
		ifEmpty: [ editorInputElement text asString ]
		ifNotEmpty: [ 
			| colItem |
			colItem := matchList items at: matchList selectedIndices first.
			colItem first ].
	party := MpAddressBook default ensureOrganizationNamed: newName.
	self transactionGroup counterparty: party.
	
	self paymentProcessor ifNotNil: [ :p | self transactionGroup paymentProcessor: p ].
	
	(self inputString = newName or: [ party aliases includes: self inputString ]) ifTrue: [ ^ self ].
	party aliases add: self inputString.
]

{ #category : #accessing }
VsCounterpartyImportElement >> transactionGroup [
	^ transactionGroup
]

{ #category : #accessing }
VsCounterpartyImportElement >> transactionGroup: anObject [
	| counterpartySuggestion nameTokens |
	transactionGroup := anObject.
	editorInputElement text: self transactionGroup input suggestion.
	memoInputElement text: self transactionGroup memo.
	self paymentProcessor ifNotNil: [ :p | paymentProcessorInputElement text: p displayString ].
	matchList items: self transactionGroup rankedMatches.
]
