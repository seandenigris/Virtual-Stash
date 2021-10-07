Class {
	#name : #VsGeneralJournalLine,
	#superclass : #Object,
	#instVars : [
		'account',
		'debit',
		'credit',
		'memo'
	],
	#category : 'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsGeneralJournalLine >> account [
	^ account
]

{ #category : #accessing }
VsGeneralJournalLine >> account: anObject [
	account := anObject
]

{ #category : #accessing }
VsGeneralJournalLine >> credit [
	^ credit
]

{ #category : #accessing }
VsGeneralJournalLine >> credit: anObject [
	credit := anObject
]

{ #category : #accessing }
VsGeneralJournalLine >> debit [
	^ debit
]

{ #category : #accessing }
VsGeneralJournalLine >> debit: anObject [
	debit := anObject
]

{ #category : #'as yet unclassified' }
VsGeneralJournalLine >> descriptionAccount [
	<magritteDescription>
	^ MAOptionDescription new
        accessor: #account;
        label: 'Account';
		classes: { VsAccount };
        priority: 100;
		beRequired;
        yourself
]

{ #category : #accessing }
VsGeneralJournalLine >> memo [
	^ memo
]

{ #category : #accessing }
VsGeneralJournalLine >> memo: anObject [
	memo := anObject
]
