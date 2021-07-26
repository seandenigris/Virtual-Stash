stencils
bridgeButton
	^ GtToolButtonStencil new 
		title: 'PBridge - Restart';
		icon: BrGlamorousVectorIcons refresh;
		action: [ :card | 
			PBApplication stop; start.
			UIManager default inform: 'Python Bridge Restarted' ];
		description: 'Stop and then start PBApplication'.