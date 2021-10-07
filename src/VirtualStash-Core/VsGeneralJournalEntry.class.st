Class {
	#name : #VsGeneralJournalEntry,
	#superclass : #Object,
	#instVars : [
		'date',
		'lines'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #magritte }
VsGeneralJournalEntry >> descriptionEntries [
	<magritteDescription>
	^ MAToManyRelationDescription new
        accessor: #lines;
        label: 'Lines';
		display: [ :e | e size asString, ' lines' ];
		classes: { VsGeneralJournalLine };
        priority: 100;
		beRequired;
        yourself
]

{ #category : #accessing }
VsGeneralJournalEntry >> lines [
	^ lines ifNil: [ lines := OrderedCollection new ]
]
