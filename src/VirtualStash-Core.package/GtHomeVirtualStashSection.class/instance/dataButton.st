stencils
dataButton
	^ GtToolButtonStencil new 
		title: 'Data';
		icon: BrGlamorousVectorIcons largeWindow;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Virtual Stash Data'
				with:
					(GtInspector
						createOn: VirtualStashDB) maximized
				from: card ].