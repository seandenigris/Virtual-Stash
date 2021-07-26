accessing
spec
	<spec: #default>

	^ SpecLayout composed
			newRow: [ :spec | spec add: #image; add: #detail; add: #ocr ];
			yourself.