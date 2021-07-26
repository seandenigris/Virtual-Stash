accessing
parser
	^ self partyParser, self separatorParser, #any asPParser star flatten