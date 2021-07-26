*VirtualStash-Core
vsCounterpartyRuleClass
	^ self propertyAt: #vsCounterpartyRuleClass ifAbsent: [ VsExplicitCounterpartyImportRule ]