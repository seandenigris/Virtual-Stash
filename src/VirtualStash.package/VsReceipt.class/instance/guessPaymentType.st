ocr-guessing
guessPaymentType

	^ VsPaymentType all detect: [ :card | hocr words anySatisfy: [ :token | token string matchesRegex: '.*x+', card lastFour asString ] ].