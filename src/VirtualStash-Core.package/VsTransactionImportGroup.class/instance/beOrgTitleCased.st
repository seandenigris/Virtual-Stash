accessing
beOrgTitleCased
	| rule |
	rule := VsImportRule
		genericPartiesEnsureNamed: self input suggestion
		aliases: #().
	self transactions do: [ :t | 
		rule
			transaction: t;
			apply ]