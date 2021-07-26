*VirtualStash-Core
isVendorFor: receipt

	^ (receipt includesSubstring: self name) or: [ self website ifNotNil: [ :url | receipt includesSubstring: url host ] ifNil: [ false ] ]