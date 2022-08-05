"
# Installation
Requires the following CLI utilities to be installed:
- Tesseract
- Imagemagick

If these binaries are not reachable via PATH, see {{gtClass:SuGenericUnixCommand}} for configuration information.
"
Class {
	#name : #BaselineOfVirtualStash,
	#superclass : #BaselineOf,
	#category : #BaselineOfVirtualStash
}

{ #category : #accessing }
BaselineOfVirtualStash class >> dataFolder [
	^ FileLocator dynabookData / 'Virtual Stash'
]

{ #category : #testing }
BaselineOfVirtualStash class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfVirtualStash >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Aconcagua' with: [
				spec repository: 'github://seandenigris/aconcagua:denigris' ];
			baseline: 'Magritte' with: [ 
				spec 
					repository: 'github://seandenigris/Magritte';
					loads: #(#default #'Magritte-Money') ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://seandenigris/Mocketry' ];
			baseline: 'MyPeople' with: [ spec repository: 'github://seandenigris/My-People' ];
			baseline: 'NeoCSV' with: [ 
				spec 
					repository: 'github://seandenigris/NeoCSV';
					loads: #('magritte') ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimplePersistence' with: [ spec repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'Talents' with: [
				spec repository: 'github://tesonep/pharo-talents' ].
		spec
			package: 'Aconcagua-Money'; "Just temporary until it stabilizes and we can merge back into Aconcagua"
			package: 'VirtualStash-Core' with: [
				spec requires: #('Aconcagua' 'Aconcagua-Money' 'Magritte' 'Mocketry' 'MyPeople' 'NeoCSV' 'PharoEnhancements' 'ResourcesLive' 'SimplePersistence' 'Talents') ] ].
				
	spec for: #notGToolkit do: [
		spec 
			baseline: 'PetitParser2' with: [
				spec repository: 'github://seandenigris/PetitParser2' ];
			baseline: 'XMLParser' with: [
				spec repository: 'github://seandenigris/XML-XMLParser' ].
		spec 
			package: 'VirtualStash-Core' with: [ 
				spec requires: #('PetitParser2' 'XMLParser') ] ].
				
	spec for: #GToolkit do: [
		spec 
			package: 'VirtualStash-GtHome';
			group: #default with: #(#'VirtualStash-Core') ]
]

{ #category : #accessing }
BaselineOfVirtualStash >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfVirtualStash >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
