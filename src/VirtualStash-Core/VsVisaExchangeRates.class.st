Class {
	#name : #VsVisaExchangeRates,
	#superclass : #Object,
	#instVars : [
		'sourceCurrency',
		'targetCurrency',
		'date',
		'json',
		'feePercentage'
	],
	#category : #'VirtualStash-Core-Bookkeeping'
}

{ #category : #accessing }
VsVisaExchangeRates class >> exampleUSDtoEUR [
	<gtExample>
	^ self
		given: [ '3/1/2023' asDate ]
		when: [ :date | self from: 'USD' to: 'EUR' on: date ]
		then: [ :calc :date |
			calc url asString should equal: 'https://bd.visa.com/cmsapi/fx/rates?amount=1&fee=0&utcConvertedDate=03/01/2023&exchangedate=03/01/2023&fromCurr=EUR&toCurr=USD'.
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
VsVisaExchangeRates class >> nowUSDtoEUR [
	| converter |
	converter := self
		from: 'USD'
		to: 'EUR'
		on: Date today.
		
	^ converter oneUnitSource
]

{ #category : #accessing }
VsVisaExchangeRates >> date [

	^ date ifNil: [ Date today ]
]

{ #category : #accessing }
VsVisaExchangeRates >> date: anObject [

	date := anObject
]

{ #category : #accessing }
VsVisaExchangeRates >> dateForUrl [

	^ String streamContents: [ :str | 
		str
			nextPutAll: (self date monthIndex asString padLeftTo: 2 with: $0);
			nextPutAll: '/';
			nextPutAll: (self date dayOfMonth asString padLeftTo: 2 with: $0);
			nextPutAll: '/';
			nextPutAll: (self date year asString) ]
			
	"Implementation note: 400 error when dates not padded"
]

{ #category : #accessing }
VsVisaExchangeRates >> exchangeRate [

	^ self oneUnitSource
]

{ #category : #accessing }
VsVisaExchangeRates >> feePercentage [
	^ feePercentage ifNil: [ 0 ]
]

{ #category : #accessing }
VsVisaExchangeRates >> feePercentage: anObject [
	feePercentage := anObject
]

{ #category : #accessing }
VsVisaExchangeRates >> json [

	^ json ifNil: [ json := STONJSON fromString: self url retrieveContents ]
]

{ #category : #accessing }
VsVisaExchangeRates >> oneUnitSource [
	^ (self json at: 'convertedAmount') asNumber
]

{ #category : #accessing }
VsVisaExchangeRates >> oneUnitTarget [
	^ (self json at: 'reverseAmount') asNumber
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
	^ 'https://bd.visa.com/cmsapi/fx/rates' asUrl
		queryAt: #amount put: 1;
		queryAt: #fee put: self feePercentage;
		queryAt: #utcConvertedDate put: self dateForUrl;
		queryAt: #exchangedate put: self dateForUrl;
		queryAt: #fromCurr put: self targetCurrency;
		queryAt: #toCurr put: self sourceCurrency;
		yourself
]
