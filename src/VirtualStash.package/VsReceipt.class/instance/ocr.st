ocr
ocr

	^ ocr ifNil: [ ocr := Tesseract ocr: imageFile ].