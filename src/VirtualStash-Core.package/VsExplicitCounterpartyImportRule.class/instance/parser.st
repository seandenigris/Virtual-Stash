private
parser
	| separator |
	separator := ($* asPParser / $- asPParser / #space asPParser) star.
	^ self paymentProcessorParser optional, separator, self partyParser, separator, self extraInfoParser end