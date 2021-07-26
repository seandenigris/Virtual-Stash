accessing
gtViewRulesOn: aView
	"Adapted from GtRefactoringsElement"

	<gtView>
	^ aView tree
		title: 'Rules';
		priority: 3;
		items: [ VsImportRule all
			select: [ :r | self transactions allSatisfy: [ :t | r appliesTo: t ] ] ];
		children: [ :e | 
			e transaction
				ifNil: [ self transactions collect: [ :t | 
					e copy transaction: t; yourself ] ]
				ifNotNil: [ #() ] ];
		itemType: [ :aTypeFactory :aTreeNode | 
			aTreeNode value transaction
				ifNotNil: [ MAPatchMacroElement ]
				ifNil: [ VsImportRuleElement ] ];
		itemStencil: [ :aNodeType | aNodeType new ];
		itemDataBinder:
				[ :anElement :aRule :anIndex | anElement rule: aRule targetingGroup: self ];
		actionUpdateButton;
		yourself