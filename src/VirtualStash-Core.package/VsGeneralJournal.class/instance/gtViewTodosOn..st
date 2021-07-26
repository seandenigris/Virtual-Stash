accessing
gtViewTodosOn: aView
	<gtView>
	| result itemStencil contextMenuContents actions |
	
	actions := {
		'Title Cased Org' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item beOrgTitleCased ].
		'Person' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item bePerson ].
		'WWW Search' -> [ :label | 
			| item |
			item := label userData at: #todo.
			item searchWWW ]
	}.
	
	contextMenuContents := [ BrGlamorousSimpleContextMenuContent new
		items: actions;
		yourself ].
	itemStencil := [ :anArray | 
	BrLabel new
		aptitude:
			BrGlamorousLabelAptitude
				+ (BrGlamorousWithContextMenuAptitude content: contextMenuContents);
		padding:
			(BlInsets
				top: 0
				left: 0
				bottom: 0
				right: 3);
		constraintsDo: [ :c | c linear horizontal alignLeft ];
		yourself ].
	^ aView tree
		title: 'TODO' translated;
		priority: 10;
		items: [ self todos ];
		itemStencil: itemStencil;
		itemDataBinder: [ :elem :item | 
			elem text: item todoString asRopedText.
			elem userData at: #todo put: item ];
		actionUpdateButtonTooltip: 'Update list';
		yourself