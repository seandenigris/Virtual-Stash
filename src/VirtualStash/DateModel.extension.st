Extension { #name : #DateModel }

{ #category : #'*VirtualStash' }
DateModel >> initializeWidgets [
	self flag: 'Override until Pharo Issue 14025 is integrated'.

	self instantiateModels: #(
		dateLabel LabelModel
		dateModel TextInputFieldModel
		chooseDateButton ButtonModel).
	
	dateLabel
		text: 'Date'.
		
	dateModel
		text: Date today asString;
		isCodeCompletionAllowed: false.
	
	chooseDateButton
		icon: self iconMorph;
		action: [ self chooseDate ];
		extent: self iconMorph extent.
]
