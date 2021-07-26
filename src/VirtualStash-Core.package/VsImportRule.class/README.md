I apply to imported transactions where the counterparty field begins with my party's name or alias, followed by optional additional info. For example:
- Additional info {{gtExample:VsCounterpartyRule class>>#exampleAcme}}
- No additional info {{gtExample:VsCounterpartyRule class>>#exampleAirbnb}}
# Scenarios
The simplest scenario is when someone already manually broke down the "vendor + random-other-info" spit out by many transaction formats into `vendor` + `memo`. So now you have a string which is the same as the vendor and the other info stored in the memo. You can update them to a real model like so:
```
name := 'Amazon'.
vendor := MpOrganization named: name.
transactionCollection "veryDeepCopy" do: [ :t | t counterparty: vendor ]
```
To do a test run, uncomment the `#veryDeepCopy` send.
# Subclasses
Should set `partyName` and override `partyParser`
# Hueristics
Common patterns of description/payee fields:
1. The whole thing is the party name
2.  The first "word" is the party
3. The first two words is the party
4. The whole thing is the party

In all cases, the vendor name may be all caps and have to be title cased. Also, for each pattern, `party` could be replaced by `alias`
# Followup
1. When something is a restaurant, do we put "restaurant" in the name? For typing reasons, if it doesn't conflict and the user knows it without, defer to the simplest thing. However, that is valid meta-information that could be put in the memo, or even better, into the tags.
2. Amazon Visa uses:
	- 'PURCHASE INTEREST CHARGE' for interest charges; interest account
	- 'AUTOMATIC PAYMENT - THANK' for payments; transfer account
There could be a rule about that. For either the payee would be the card issuer. Or maybe credit card accounts can have that meta-info?
