ocr-guessing
guessVendor

	^ hocr words detect: [ :e | e string = 'H&M' ] ifNone: [ '?' ].