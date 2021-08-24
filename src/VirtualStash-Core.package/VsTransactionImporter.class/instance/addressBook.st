accessing
addressBook
	"By default, leave counterpartys as strings, don't convert to domain objects. This is because e.g. GnuCash doesn't have a strong counterparty concept, but a generic description, which could be any unstructured text and might lead to false matches"
	^ addressBook