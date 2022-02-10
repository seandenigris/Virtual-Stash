Class {
	#name : #VsVisaExchangeRates,
	#superclass : #Object,
	#instVars : [
		'sourceCurrency',
		'targetCurrency',
		'date'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsVisaExchangeRates class >> exampleUSDtoEUR [
	<gtExample>
	^ self
		given: []
		when: [ self from: 'USD' to: 'EUR' on: Date today ]
		then: [ :calc |
			calc url asString should equal: 'https://bd.visa.com/travel-with-visa/exchange-rate-calculator.html?utcConvertedDate=&submitButton=Calculate%20Exchange%20Rates&fromCurr=USD&toCurr=EUR&fee=0&exchangedate=2%252F10%252F2022'.
			calc ]
]

{ #category : #accessing }
VsVisaExchangeRates class >> from: source to: target on: aDate [
	^ self new
		sourceCurrency: source;
		targetCurrency: target;
		date: aDate;
		yourself
]

{ #category : #accessing }
VsVisaExchangeRates >> date [

	^ date
]

{ #category : #accessing }
VsVisaExchangeRates >> date: anObject [

	date := anObject
]

{ #category : #accessing }
VsVisaExchangeRates >> oneUnitSource [
	| soup |
	soup := Soup fromUrl: self url.
	^ ((soup hr nextSibling nextSibling / #p) second text splitOn: Character space) fourth asNumber
]

{ #category : #accessing }
VsVisaExchangeRates >> oneUnitTarget [
	| soup |
	soup := Soup fromUrl: self url.
	^ ((soup hr nextSibling nextSibling / #p) first text splitOn: Character space) fourth asNumber
]

{ #category : #accessing }
VsVisaExchangeRates >> sourceCurrency [

	^ sourceCurrency
]

{ #category : #accessing }
VsVisaExchangeRates >> sourceCurrency: anObject [

	sourceCurrency := anObject
]

{ #category : #accessing }
VsVisaExchangeRates >> targetCurrency [

	^ targetCurrency
]

{ #category : #accessing }
VsVisaExchangeRates >> targetCurrency: anObject [

	targetCurrency := anObject
]

{ #category : #accessing }
VsVisaExchangeRates >> url [
	^ 'https://bd.visa.com/travel-with-visa/exchange-rate-calculator.html?utcConvertedDate=&submitButton=Calculate+Exchange+Rates' asUrl
		queryAt: #fromCurr put: self sourceCurrency;
		queryAt: #toCurr put: self targetCurrency;
		queryAt: #fee put: 0;
		queryAt: #exchangedate put: self date mmddyyyy urlEncoded;
		yourself
]
