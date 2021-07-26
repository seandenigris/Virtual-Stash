serializing
fuelOutAs: base
	"Stash obsolete data somewhere so we can start over"
	FLSerializer serialize: self toFileNamed: (FileLocator virtualStashData / 'Fuelouts' / base, 'fuel') fullName