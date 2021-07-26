acessing-magritte
descriptionContainer
	"Return the default description container."
	<magritteContainer>
	^ super descriptionContainer
		blocClass: MACompositeElementBuilder;
		yourself