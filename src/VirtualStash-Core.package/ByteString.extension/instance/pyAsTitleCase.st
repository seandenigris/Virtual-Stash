*VirtualStash-Core
pyAsTitleCase
	"See https://pypi.org/project/titlecase/"

	^ PBApplication uniqueInstance newCommandStringFactory
    addAllBindings: { 
        #input -> self } asDictionary;
    script: 'from titlecase import titlecase';
    resultExpression: 'titlecase(input)';
    sendAndWait.