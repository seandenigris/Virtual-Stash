Class {
	#name : #GtHomeVirtualStashSection,
	#superclass : #GtHomeSection,
	#instVars : [
		'cardsContainer'
	],
	#category : 'VirtualStash-Core-GToolkit'
}

{ #category : #stencils }
GtHomeVirtualStashSection >> addressBookButton [
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
]

{ #category : #stencils }
GtHomeVirtualStashSection >> booksButton [
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
]

{ #category : #stencils }
GtHomeVirtualStashSection >> bridgeButton [
	^ GtToolButtonStencil new 
		title: 'PBridge - Restart';
		icon: BrGlamorousVectorIcons refresh;
		action: [ :card | 
			PBApplication stop; start.
			UIManager default inform: 'Python Bridge Restarted' ];
		description: 'Stop and then start PBApplication'.
]

{ #category : #stencils }
GtHomeVirtualStashSection >> coderButton [
	^ GtToolButtonStencil new 
		title: 'Coder';
		icon: BrGlamorousVectorIcons largeBook;
		action: [ :card | self error: 'how to?' ].
]

{ #category : #'api - instantiation' }
GtHomeVirtualStashSection >> create [
	| sectionContainer |
	sectionContainer := self newSectionContainer.
	sectionContainer addChild: (self newSectionTitle: 'Virtual Stash').

	cardsContainer := self newCardsContainer
		addChild: self coderButton create;
		addChild: self addressBookButton create;
		addChild: self booksButton create;
		addChild: self bridgeButton create;
		yourself.
		
	sectionContainer addChild: cardsContainer.
	^ sectionContainer
]

{ #category : #stencils }
GtHomeVirtualStashSection >> dataButton [
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
]
