accessing
generalJournalElementExample
	| ts tFields container rowTemplate cellTemplate blankTemplate headerCells anyT anyS sFields tCells sCells cell1Widths newWidth |
	ts := self generalJournal transactions first: 5.
	anyT := ts first.
	anyS := anyT splits first.
	tFields := { anyT dateDescription. anyT numberDescription. anyT counterpartyDescription }.
	sFields := {
						anyS accountDescription.
						(anyS statusDescription
							display: [ :e | e class gnuCashCode ];
							yourself).
						anyS debitAmountDescription.
						anyS creditAmountDescription}.			
	container := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		yourself.
	rowTemplate := BrValuableStencil
		from: [ BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 22 ];
				yourself ].
	cellTemplate := BrValuableStencil
		from: [ BlTextElement new
				border: (BlBorder paint: Color black width: 1);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 20 ];
				padding: (BlInsets all: 5);
				background: Color paleGreen darker darker darker darker;
				yourself ].
	blankTemplate := BrValuableStencil
		from: [ BlTextElement new
				text: '' asRopedText;
				border: (BlBorder paint: Color black width: 1);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical exact: 20 ];
				padding: (BlInsets all: 5);
				background: Color paleGreen darker darker darker darker;
				yourself ].
	headerCells := tFields , sFields
		collect: [ :desc | 
			cellTemplate create
				text: desc label asRopedText;
				yourself ].
	container
		addChild:
			(rowTemplate create
				addChildren: headerCells;
				yourself).
	ts
		do: [ :t | 
			tCells := tFields
				collect: [ :desc | 
					cellTemplate create
						text: (desc toString: (desc read: t)) asRopedText;
						yourself ].
			tCells := tCells
				,
					{blankTemplate create.
					blankTemplate create.
					blankTemplate create}.
			container
				addChild:
					(rowTemplate create
						addChildren: tCells;
						yourself).
			t splits
				do: [ :s | 
					sCells := sFields
						collect: [ :desc | 
							cellTemplate create
								text: (desc toString: (desc read: s)) asRopedText;
								yourself ].
					sCells := {blankTemplate create.
					blankTemplate create.
					blankTemplate create} , sCells.
					container
						addChild:
							(rowTemplate create
								addChildren: sCells;
								yourself) ] ].
	container forceLayout.
	cell1Widths := container children
		collect: [ :e | e children first width ].
	newWidth := cell1Widths max.
	container children do: [ :e | e children first width: newWidth ].
	^ container