*VirtualStash-Core
copyApplicationTo: appFolder application: application
	"Copy the PythonBridge runtime environment to the specified folder"
	| srcDir cpCommand proc srcFilename dstFilename error |

	srcDir := self runtimeSourceDirectoryFor: application.
	srcDir resolve = appFolder resolve ifTrue: [ ^ self ].

	"Copy the runtime directory"
	srcFilename := srcDir resolve fullName copyReplaceAll: '"' with: '\"'.
	dstFilename := appFolder resolve fullName copyReplaceAll: '"' with: '\"'.
	cpCommand := String streamContents: [ :stream |
		stream
			<< 'cp -a "';
			<< srcFilename;
			<< '" "';
			<< dstFilename;
			<< '"' ].
	proc := PBUnixSubprocess new 
		shellCommand: cpCommand;
		runAndWait.
	proc isSuccess ifFalse:
		[ error := PBPythonProcessError new
			messageText: 'Unable to install PythonBridge runtime';
			application: application;
			process: proc.
		error signal ].
	
	(appFolder / 'Pipfile') delete.
	FileLocator localDirectory / 'Iceberg' / 'seandenigris' / 'Virtual-Stash' / 'python' / 'Pipfile' copyTo: appFolder / 'Pipfile'..
