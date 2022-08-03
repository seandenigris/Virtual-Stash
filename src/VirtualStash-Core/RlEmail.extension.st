Extension { #name : #RlEmail }

{ #category : #'*VirtualStash-Core' }
RlEmail >> datesRecognized [
	| datesInBody |
	
	"Adapted from https://kursjan.github.io/petitparser2/scripting.html"
	datesInBody := Date pp2Parser islandInSea star parse: self mailMessage bodyTextFormatted. "#bodyText may be e.g. base64 encoded"
	
	^ datesInBody asSet 
			add: self timestamp asDate;
			yourself
]

{ #category : #'*VirtualStash-Core' }
RlEmail >> possibleCurrencyAmounts [
	| matches |
	
	"Adapted from https://kursjan.github.io/petitparser2/scripting.html"
	self error: 'Port to Money'.
	"matches := (AmDollar parser sea ==> #second) star parse: self mailMessage bodyTextFormatted."
	
	^ matches asSet
]
