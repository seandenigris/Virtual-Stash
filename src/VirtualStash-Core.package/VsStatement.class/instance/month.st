accessing
month
	| tokens |
	tokens := self file base splitOn: '-'.
	^ Month year: tokens first asNumber month: tokens second asNumber