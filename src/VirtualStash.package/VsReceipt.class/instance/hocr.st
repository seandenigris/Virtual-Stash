ocr
hocr

	^ hocr ifNil: [ hocr := Tesseract hocr: self imageFile ].