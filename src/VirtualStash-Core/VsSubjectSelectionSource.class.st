"
I am a deliberately thin experimental subject-selection source.

I expose the existing DbSoup GT searches and derive the relation's accepted classes from the Dynabook object-reference map. This lets Virtual Stash try the existing cross-domain infrastructure before growing its own source registry or selection policy.
"
Class {
	#name : 'VsSubjectSelectionSource',
	#superclass : 'Object',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'examples' }
VsSubjectSelectionSource class >> exampleMappedSubjectFamilies [
	<gtExample>

	| source classes |
	source := self new.
	classes := source subjectClasses.

	(classes identityIncludes: PpValue) should beTrue.
	(classes identityIncludes: PpInventoryItem) should beTrue.
	(classes identityIncludes: CwSoftware) should beTrue.

	^ source

]

{ #category : 'gt-search' }
VsSubjectSelectionSource >> gtSpotterSearchesInContext: aSpotterContext [
	^ DbSoup uniqueInstance
		gtSpotterSearchesInContext: aSpotterContext

]

{ #category : 'accessing' }
VsSubjectSelectionSource >> subjectClasses [
	| classes |
	classes := IdentitySet new.

	BaselineOfDynabook new dbReferenceBuilderMap keysDo: [ :aClass |
		classes addAll: aClass withAllSubclasses ].

	^ classes

]
