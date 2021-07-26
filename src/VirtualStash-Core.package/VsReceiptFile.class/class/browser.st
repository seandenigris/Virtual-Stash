as yet unclassified
browser
		| browser |
	browser := GLMTabulator new.
	browser
		column: #list;
		column: #form;
		column: #image.
	(browser transmit)
		to: #list;
		andShow: [ :a | a list display: [ :file | file receipts ] ].
	(browser transmit)
		to: #form;
		from: #list;
		andShow: [ :a | a magritte display: [ :receipt | receipt ] ].
	(browser transmit)
		to: #image;
		from: #list;
		andShow: [ :a | 
					a morph
						display: [ :receipt | receipt ] ].
	^ browser