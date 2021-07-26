private
extraInfoParser
	^ #any asPParser star flatten trimBlanks optional ==> [ :n | n ifNotNil: [ :s | s withBlanksCondensed trimBoth ] ]