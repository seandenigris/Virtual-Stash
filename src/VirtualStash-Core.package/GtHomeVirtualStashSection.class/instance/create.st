api - instantiation
create
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