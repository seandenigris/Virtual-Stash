accessing
gtPatchViewFor: aView
	<gtView>
	self patch ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Patch';
		priority: 25;
		object: [ self patch ];
		view: #gtElementViewFor: