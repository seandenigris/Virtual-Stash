protocol
words

	| wordNodes |
	wordNodes := self xmlDocument allElementsSelect: [ :e | (e attributeAt: 'class') = 'ocrx_word' ].
	^ wordNodes collect: [ :e | HocrWord on: e ].