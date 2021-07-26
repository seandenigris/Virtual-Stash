accessing
rule: aRule targetingGroup: group
	| newLabel newTarget newButtonLabel |
	self rule: aRule.
	newTarget := group.
	newLabel := aRule displayName.
	newButtonLabel := 'Apply to All'.
			
	(self childNamed: #label) text: newLabel asRopedText.
	self target: newTarget.
	(self childNamed: #button) label: newButtonLabel