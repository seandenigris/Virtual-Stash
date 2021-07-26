GT
gtInspectorDomainIn: composite
	<gtInspectorPresentationOrder: 3>
	^ composite table
		title: 'Receipt';
		display: [
				self magritteDescription children collect: [ :desc |
					desc label -> (desc accessor read: self) ] ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value