Extension { #name : #MpOrganization }

{ #category : #'*VirtualStash-Core' }
MpOrganization >> vsBePaymentProcessor [
	^ VsBooks paymentProcessors add: self
]

{ #category : #'*VirtualStash-Core' }
MpOrganization >> vsCounterpartyRule [
	^ self vsCounterpartyRuleClass new
		party: self;
		yourself
]

{ #category : #'*VirtualStash-Core' }
MpOrganization >> vsCounterpartyRuleClass [
	^ self propertyAt: #vsCounterpartyRuleClass ifAbsent: [ VsExplicitCounterpartyImportRule ]
]

{ #category : #'*VirtualStash-Core' }
MpOrganization >> vsCounterpartyRuleClass: aClass [
	self propertyAt: #vsCounterpartyRuleClass put: aClass
]

{ #category : #'*VirtualStash-Core' }
MpOrganization >> vsNameParser [
	| names |
	"We sort by size descending to ensure the longest match, preventing partial matches"
	names := (self aliases copyWith: self fullName) asSortedCollection: #size descending.
	^ names allButFirst 
		inject: names first asPParser caseInsensitive 
		into: [ :result :alias | result / alias asPParser caseInsensitive ]
]
