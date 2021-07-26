as yet unclassified
initializePresenter

	ocr list whenSelectedItemChanged: [ :line | | imageMorph |
		line ifNotNil: [ 
			imageMorph := image submorphs first submorphs first.
			imageMorph select: line ] ].