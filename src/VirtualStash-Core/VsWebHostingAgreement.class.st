"
I represent an agreement for web-hosting services that supports one or more Internet domains.

I am intentionally small and provisional. I exist as a design probe to discover whether web-hosting agreements have enough distinctive behavior to justify a specialized agreement type. At present, my only web-hosting-specific responsibility is identifying the domains supported by the agreement through #domains.

Do not add hosting concepts merely because they are conceivable. Add behavior only when required by concrete use cases.

Experience may show that:

- web-hosting agreements warrant their own type;
- #domains is an instance of a more general agreement relationship, such as covering or supporting domain objects; or
- responsibility for the hosted domains belongs on a richer Computer World object used as the agreement subject.

If either of the latter models proves more expressive, migrate the relationship and remove this specialization.
"
Class {
	#name : 'VsWebHostingAgreement',
	#superclass : 'VsAgreement',
	#instVars : [
		'domains'
	],
	#classVars : [
		'subjectDefault'
	],
	#category : 'VirtualStash-Core-Agreements',
	#package : 'VirtualStash-Core',
	#tag : 'Agreements'
}

{ #category : 'accessing' }
VsWebHostingAgreement class >> subjectDefault [

  ^ subjectDefault
]

{ #category : 'accessing' }
VsWebHostingAgreement class >> subjectDefault: anObject [

  subjectDefault := anObject
]

{ #category : 'as yet unclassified' }
VsWebHostingAgreement >> displaySubjectOn: aStream [

	super displaySubjectOn: aStream.
	aStream nextPutAll: ' for '.
	self domains
		do: [ :d | aStream display: d ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : 'accessing' }
VsWebHostingAgreement >> domains [

  ^ self maLazyInstVarUsing: self domainsDescription
]

{ #category : 'accessing' }
VsWebHostingAgreement >> domains: anObject [

  domains := anObject
]

{ #category : 'accessing' }
VsWebHostingAgreement >> domainsAdd: aUrl [

	^ self domains add: aUrl
	
	"Created for use in cascades"
]

{ #category : 'as yet unclassified' }
VsWebHostingAgreement >> domainsDescription [
	<magritteDescription>

	^ MAToManyRelationDescription new
		accessor: #domains;
		default: OrderedCollection new;
		classes: ZnUrl withAllSubclasses;
		comment:
			'The Internet domains supported by this hosting agreement.';
		yourself
]

{ #category : 'as yet unclassified' }
VsWebHostingAgreement >> subject [

	^ self class subjectDefault
]
