accessing
openingBalance
	^ openingBalance ifNil: [ openingBalance := self openingBalanceDescription default ]