*VirtualStash-Core
possibleCurrencyAmounts
	| matches |
	
	"Adapted from https://kursjan.github.io/petitparser2/scripting.html"
	self error: 'Port to Money'.
	"matches := (AmDollar parser sea ==> #second) star parse: self mailMessage bodyTextFormatted."
	
	^ matches asSet