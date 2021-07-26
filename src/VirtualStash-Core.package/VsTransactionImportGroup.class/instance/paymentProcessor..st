accessing
paymentProcessor: anMpOrganization
	self transactions do: [ :t | t processor: anMpOrganization ]