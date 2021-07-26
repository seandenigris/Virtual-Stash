as yet unclassified
printRegister: account
	| transactions balance |
	transactions := self generalJournal transactions select: [ :trans | trans accounts includes: account ].
	balance := account openingBalance.
	^ String streamContents: [ :str |
			transactions
				do: [ :t | str
					nextPutAll: t registerString;
					tab;
					print: balance ]
				separatedBy: [ str crlf ] ]