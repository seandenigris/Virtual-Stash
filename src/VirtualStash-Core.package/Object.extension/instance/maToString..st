*VirtualStash-Core
maToString: aSymbol
	| description |
	description := self perform: aSymbol.
	^ description toString: (description accessor read: self)