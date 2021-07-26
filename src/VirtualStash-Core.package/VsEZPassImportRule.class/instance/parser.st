accessing
parser
	^ ('NEW JERSEY' asPParser / 'NYS THRUWAY' asPParser) trimBlanks optional, super parser ==> [ :n | { nil. nil. nil. nil. n first } ]