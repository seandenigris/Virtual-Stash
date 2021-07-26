protocol
xmlDocument

	| parser |
	parser := XMLDOMParser on: string.
	^ parser
		resolvesExternalEntities: false;
		parseDocument.