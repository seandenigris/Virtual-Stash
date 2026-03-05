Class {
	#name : 'VsVisaAccount',
	#superclass : 'VsCreditCardAccount',
	#category : 'VirtualStash-Core-Bookkeeping',
	#package : 'VirtualStash-Core',
	#tag : 'Bookkeeping'
}

{ #category : 'accessing' }
VsVisaAccount >> currencyConverter [

	^ VsVisaExchangeRates new
		feePercentage: self foreignTransactionFee * 100.0;
		yourself
]
