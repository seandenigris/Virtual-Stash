testing
isValidPaymentType

	^ VsPaymentMethod all anySatisfy: [ :e | e isPaymentTypeFor: self string ]