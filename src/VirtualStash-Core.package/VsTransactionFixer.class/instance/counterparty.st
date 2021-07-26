accessing
counterparty
	^ counterparty ifNil: [ counterparty := (self parser parse: self input) first ]