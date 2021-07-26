as yet unclassified
refresh

	| imageMorph detailMorph |
	imageMorph := receipt asMorph.
	image widget
		removeAllMorphs;
		addMorph: imageMorph.
	imageMorph addFlexShell
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	
	ocr receipt: receipt.
	
	detailMorph := receipt asMagritteMorph morph
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	detail
		removeAllMorphs;
		addMorph: detailMorph.