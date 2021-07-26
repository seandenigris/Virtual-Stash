stencils
booksButton
	^ GtToolButtonStencil new 
		title: 'Books - Personal';
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Books - Personal'
				with:
					(GtInspector
						createOn: VsBooks personal) maximized
				from: card ];
		description: 'Inspect personal books'.