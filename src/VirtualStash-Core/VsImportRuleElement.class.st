Class {
	#name : #VsImportRuleElement,
	#superclass : #BlElement,
	#instVars : [
		'target',
		'rule'
	],
	#category : 'VirtualStash-Core'
}

{ #category : #accessing }
VsImportRuleElement >> initialize [
	super initialize.
	self
			layout: (BlLinearLayout horizontal cellSpacing: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude) as: #label;
			addChild: (BrButton new
				beSmallSize;
				aptitude: BrGlamorousButtonWithLabelAptitude;
				action: [ self target applyRule: self rule ];
				label: 'Apply') as: #button
]

{ #category : #accessing }
VsImportRuleElement >> rule [
	^ rule
]

{ #category : #accessing }
VsImportRuleElement >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
VsImportRuleElement >> rule: aRule targetingGroup: group [
	| newLabel newTarget newButtonLabel |
	self rule: aRule.
	newTarget := group.
	newLabel := aRule displayName.
	newButtonLabel := 'Apply to All'.
			
	(self childNamed: #label) text: newLabel asRopedText.
	self target: newTarget.
	(self childNamed: #button) label: newButtonLabel
]

{ #category : #accessing }
VsImportRuleElement >> target [
	^ target
]

{ #category : #accessing }
VsImportRuleElement >> target: anObject [
	target := anObject
]
