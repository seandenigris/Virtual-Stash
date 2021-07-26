world menu
menuCommandOn: aBuilder  
	<worldMenu>
	(aBuilder item: #'Virtual Stash')
		with: [
			(aBuilder item: #'Inspect DB')
				order: 1.0;
				action: [ self spData inspect ].
			(aBuilder item: #'Open Receipt Browser')
				order: 2.0;
				action: [ VsReceiptBrowser open ] ].