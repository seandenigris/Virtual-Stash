instance creation
paid: amount on: aDate for: descriptionString inCategory: categoryString 

	^ self new
		setAmount: amount
		date: aDate
		description: descriptionString
		category: categoryString.