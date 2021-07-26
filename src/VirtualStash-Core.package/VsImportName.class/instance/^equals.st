comparing
= rhs
	^ self species = rhs species and: [ self string = rhs string ]
	"Implementation note: added species check for Magritte patching #isNoOp check against real domain object"