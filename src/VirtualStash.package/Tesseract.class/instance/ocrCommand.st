private
ocrCommand

	| template |
	template := '"{1}" "{2}" "{3}"'.
	^ template format: { self executable fullName. inputFile fullName. tempFileBase fullName }.