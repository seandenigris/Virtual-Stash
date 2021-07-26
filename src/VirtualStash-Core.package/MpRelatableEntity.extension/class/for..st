*VirtualStash-Core
for: receipt

	^ self all detect: [ :e | e isVendorFor: receipt ] ifNone: [ nil ]