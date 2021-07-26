private
addOcrBoxes

	receipt hocr lines do: [ :e | | boxMorph |
		boxMorph := BorderedMorph new
			color: Color transparent;
			bounds: e boundingBox;
			yourself.
		boxMorph topLeft: self topLeft + e boundingBox topLeft.
		self addMorph: boxMorph ]