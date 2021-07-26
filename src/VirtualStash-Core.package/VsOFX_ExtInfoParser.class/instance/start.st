accessing
start
	^ header, '|Trans type:Generic ' asPParser, ('debit' asPParser / 'credit' asPParser), memo optional end ==> #last