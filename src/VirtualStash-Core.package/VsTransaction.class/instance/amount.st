accessing
amount
	| credits debits creditTotal debitTotal |
	credits := self splits select: #isCredit.
	debits := self splits select: #isDebit.
	creditTotal := credits inject: 0 dollars into: [ :sum :e | sum + e amount ].
	debitTotal := debits inject: 0 dollars into: [ :sum :e | sum + e amount ].
	^ creditTotal max: debitTotal