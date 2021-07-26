initialization
initializeWidgets

	image := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.

	ocr := self instantiate: HocrBrowser.
	
	detail := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.