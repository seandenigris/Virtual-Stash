stencils
addressBookButton
	^ GtToolButtonStencil new 
		title: 'Address Book';
		icon: BrGlamorousVectorIcons robot;
		action: [ :card | 
			self
				showSpaceWithTitle: 'Address Book'
				with:
					(GtInspector
						createOn: MpAddressBook default) maximized
				from: card ];
		description: 'Inspect default address book'.