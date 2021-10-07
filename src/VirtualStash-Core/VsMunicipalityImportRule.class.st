Class {
	#name : #VsMunicipalityImportRule,
	#superclass : #VsExplicitCounterpartyImportRule,
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #examples }
VsMunicipalityImportRule class >> exampleNewRochelle [
	<gtExample>
	self givenInput: 'New Rochelle' thenPartyNamed: 'City of New Rochelle'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleNewRochelleLocalBusinessDontApply [
	<gtExample>
	self
		given: 'New Rochelle Gas' 
		thenDontMatchMunicipalityNamed: 'City of New Rochelle'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleNewRochelleMemo [
	<gtExample>
	self givenInput: 'CITY OF NEW ROCH AB34E' thenPartyNamed: 'City of New Rochelle' andMemoAppendedWith: 'AB34E'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleWhitePlains [
	<gtExample>
	self givenInput: 'White Plains' thenPartyNamed: 'City of White Plains'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleWhitePlainsLocalBusinessDontApply [
	<gtExample>
	self
		given: 'White Plains Florist' 
		thenDontMatchMunicipalityNamed: 'City of White Plains'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleWhitePlainsParking [
	<gtExample>
	self givenInput: 'WHITE PLAINS PARKING-P' thenPartyNamed: 'City of White Plains' andMemoAppendedWith: 'PARKING-P'
]

{ #category : #examples }
VsMunicipalityImportRule class >> exampleWhitePlainsParking2 [
	<gtExample>
	self givenInput: 'WHITE PLAINS PARK DPT' thenPartyNamed: 'City of White Plains' andMemoAppendedWith: 'PARK DPT'
]

{ #category : #examples }
VsMunicipalityImportRule class >> given: inputString thenDontMatchMunicipalityNamed: municipalityName [
	[ 
		self
			given: inputString
			appliedTo: []
			then: [ :t | self assert: t counterparty fullName ~= municipalityName ]
	] on: Error do: [ "will end up here if no rule for input; not relevant to this test" ]
]

{ #category : #testing }
VsMunicipalityImportRule class >> isAbstract [
	^ self = VsMunicipalityImportRule
]

{ #category : #accessing }
VsMunicipalityImportRule >> appliesTo: aVsTransaction [
	| input commonNameParser commonNamePlusParser parseResult |
	input := aVsTransaction counterparty asString.
	
	"Since local businesses may have names starting with the municipality name, to avoid wrongly applying in those cases, only match if the input is known to be municipality-related"
	commonNameParser := self commonName asPParser caseInsensitive.
	commonNamePlusParser := commonNameParser, #any asPParser star flatten trimBlanks ==> #second.
	parseResult := commonNamePlusParser parse: input.
	^ parseResult isPetit2Success
		ifTrue: [ parseResult isEmpty or: [ self suffixes includes: parseResult ] ]
		ifFalse: [ super appliesTo: aVsTransaction ]
]

{ #category : #accessing }
VsMunicipalityImportRule >> commonName [
	^ self party propertyAt: #vsCommonName
]

{ #category : #accessing }
VsMunicipalityImportRule >> suffixes [
	^ self party propertyAt: #vsCounterpartySuffixes
]
