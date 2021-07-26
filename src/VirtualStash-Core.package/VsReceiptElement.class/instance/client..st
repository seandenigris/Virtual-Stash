accessing
client: aReceipt
	| shortcutDescriptions |
	super client: aReceipt.
	shortcutDescriptions := self client magritteDescription select: [ :e | e hasProperty: #shortcut ].
	shortcutDescriptions do: [ :e |
		| shortcut keyCombo |
		keyCombo := BlKeyCombination builder key: BlKeyboardKey perform: e propertyAt: #shortcut; build.
		shortcut := BlShortcut new
		combination: keyCombo;
		action: [ :anEvent :aShortcut | 
			| selectedText |
			selectedText := self selection first userData at: #node.
			self client date: selectedText string asDate ].
	]