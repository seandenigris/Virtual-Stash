accessing
backupDirectory

	^ (FileLocator home / 'Dropbox' / 'Pharo Data' / 'Virtual Stash' / self backupDirectoryName) ensureCreateDirectory