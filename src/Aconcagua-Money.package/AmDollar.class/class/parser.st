accessing
parser
	^ RxMatcher forString: '\$(\d+(.\d+)?)'.
	"| symbol amount |
	symbol := $$ asPParser.
	amount := #digit asPParser plus, ($. asPParser, #digit asPParser, #digit asPParser) optional.
	^ (symbol, amount flatten) ==> [ :n | n second asNumber dollars ]"