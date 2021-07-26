*VirtualStash-Core
vsNameParser
	| names |
	"We sort by size descending to ensure the longest match, preventing partial matches"
	names := (self aliases copyWith: self fullName) asSortedCollection: #size descending.
	^ names allButFirst 
		inject: names first asPParser caseInsensitive 
		into: [ :result :alias | result / alias asPParser caseInsensitive ]