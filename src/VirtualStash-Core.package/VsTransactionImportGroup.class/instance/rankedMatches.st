accessing
rankedMatches

	| choices reply |
	choices := MpAddressBook default contacts collect: #fullName.
	reply := PBApplication uniqueInstance newCommandStringFactory
    addAllBindings: { 
        #choices -> choices asArray.
        #maxResults -> 50.
        #input -> self input counterpartyName } asDictionary;
    script: 'from fuzzywuzzy import process';
    resultExpression: 'process.extract(input, choices, limit=maxResults)';
    sendAndWait.
    ^ reply
    
    "Note: We let fuzzywuzzy use the default (and slower) Ratcliff-Obershelp algorithm[1] from difflib, rather than load Levenstein distance [3] because a sequence-based algorithm seems more appropriate [3]
    
    1. https://github.com/seatgeek/fuzzywuzzy/issues/128#issuecomment-766208348
    2. https://pypi.org/project/fuzzywuzzy/
    3. https://itnext.io/string-similarity-the-basic-know-your-algorithms-guide-3de3d7346227"