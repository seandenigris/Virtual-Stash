actions
applyRule: aRule
	self transactions do: [ :t | t applyRule: aRule copy ]