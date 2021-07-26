accessing
add: aVsAccount
	aVsAccount books: self books.
	^ self accounts add: aVsAccount
	"Implementation note: I should be responsible for adding accounts, but to properly initialize them during that process, I must know my books"