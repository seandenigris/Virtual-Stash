*VirtualStash-Core
possibleDates
	| datesInBody |
	
	"Adapted from https://kursjan.github.io/petitparser2/scripting.html"
	datesInBody := Date pp2parser islandInSea star parse: self mailMessage bodyTextFormatted. "#bodyText may be e.g. base64 encoded"
	
	^ datesInBody asSet 
			add: self timestamp asDate;
			yourself