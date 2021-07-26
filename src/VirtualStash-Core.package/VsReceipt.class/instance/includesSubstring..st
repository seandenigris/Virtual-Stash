testing
includesSubstring: aString 
	"Case-insensitive"

	^ self hocr lines anySatisfy: [ :line | line string asLowercase includesSubstring: aString asLowercase ]