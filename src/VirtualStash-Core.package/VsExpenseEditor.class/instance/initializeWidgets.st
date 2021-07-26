initialization
initializeWidgets

	self instantiateModels: #(
		dateLabel LabelModel
		date	DateModel
		accountLabel LabelModel
		account TextInputFieldModel
		descriptionLabel LabelModel
		description TextInputFieldModel
		amountLabel LabelModel
		amount		TextInputFieldModel).
		
	dateLabel text: 'Date'.
	accountLabel text: 'Account'.
	descriptionLabel text: 'Description'.
	amountLabel text: 'Amount'.

	date dateModel
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	date focusOrder
		add: date dateModel;
		add: account.
	
	account
		entryCompletion: self accountNameCompletion";
		acceptBlock: [ :t | Halt now ];
		whenTextIsAccepted: [ :t | Halt now ]";
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	description
		entryCompletion: self descriptionCompletion;
		keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.
	amount
		entryCompletion: self amountCompletion;
	keyStrokeForNextFocus: Character tab asShortcut;
		keyStrokeForPreviousFocus: Character tab shift asShortcut.

	self focusOrder
		add: date dateModel;
		add: account;
		add: description;
		add: amount.