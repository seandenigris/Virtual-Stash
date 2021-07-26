instance creation
onIIF: aString 

	^ self subclasses detect: [ :e | e iifDescription = aString ] ifNone: [
			| newClassName |
			newClassName := UIManager default request: 'Account type ', aString, ' does not exist. Type class name to add...' initialAnswer: 'VsQb', aString asLegalSelector capitalized, 'AccountType'.
			newClassName ifNil: [ ^ self ].
			VsQbAccountType subclass: newClassName asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				poolDictionaries: ''
				category: 'VirtualStash'.
			(Smalltalk at: newClassName asSymbol) class compile: 'description
	
	^ ''', aString, '''.' classified: 'accessing' ].