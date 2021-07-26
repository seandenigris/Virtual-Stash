ocr-guessing
guessPaymentType

	^ VsPaymentMethod all detect: [ :card | hocr words anySatisfy: [ :token | token string matchesRegex: '.*x+', card lastFour asString ] ].