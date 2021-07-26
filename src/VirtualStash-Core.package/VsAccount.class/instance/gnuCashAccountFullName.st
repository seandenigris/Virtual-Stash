accessing
gnuCashAccountFullName
	"The reason this selector is so complex (e.g. vs. #fullName) is that we need something unique to implement on ByteString while assembling the account tree from CSV"
	| path |
	path := parent ifNotNil: [ :p | p gnuCashAccountFullName, ':' ] ifNil: [ '' ].
	^ path, self name