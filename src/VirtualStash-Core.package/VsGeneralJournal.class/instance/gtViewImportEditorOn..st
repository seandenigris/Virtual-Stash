accessing
gtViewImportEditorOn: aView
	<gtView>
	| result |
	^ aView columnedList
		title: 'Import Editor' translated;
		priority: 20;
		items: [ (self todos at: 24) last ];
		"send: #self;"
		column: 'Input' do: [ :clm | 
			clm stencil: [ :e | 
			"BlTextElement new
		text: e counterparty asRopedText;
		yourself."
			BrEditor new
		look: BrGlamorousEditorLook;
		text: e counterparty;
		fitContent;
		yourself.
		"BlElement new
				background: Color blue;
				yourself" ] ];
		yourself.