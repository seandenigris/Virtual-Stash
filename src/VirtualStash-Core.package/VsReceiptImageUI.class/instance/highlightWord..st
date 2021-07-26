private
highlightWord: aHocrWord

	| newMorph |
	newMorph := aHocrWord asMorph.
	newMorph
		topLeft: self topLeft + aHocrWord boundingBox topLeft.
	self addMorph: newMorph.