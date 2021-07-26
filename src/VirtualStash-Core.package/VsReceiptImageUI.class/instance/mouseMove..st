event handling
mouseMove: anEvent

	| hoveredWord |
	(self isHighlightingWordAt: anEvent cursorPoint) ifTrue: [ ^ self ].
	hoveredWord := receipt hocr words
		detect: [ :e | e boundingBox containsPoint: anEvent cursorPoint - self topLeft ]
		ifNone: [ ^ self ].
	self highlightWord: hoveredWord.