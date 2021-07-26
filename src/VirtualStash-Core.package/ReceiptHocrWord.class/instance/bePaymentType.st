as yet unclassified
bePaymentType

	| paymentType |
	paymentType := VsPaymentMethod all detect: [ :e | e isPaymentTypeFor: self string ].
	self receipt paymentMethod: paymentType