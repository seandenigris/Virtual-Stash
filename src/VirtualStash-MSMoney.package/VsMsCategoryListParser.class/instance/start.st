as yet unclassified
start

	| branch |
	branch := rootAccount, (#newline asParser, childAccount plus) star.
	^ (branch separatedBy: #newline asParser) end ==> [ :n | self rootCategories ]