accessing
gtOCRFor: aView
	<gtView>
	^ aView text
		priority: 3;
		title: 'OCR';
		text: [ self ocr ]