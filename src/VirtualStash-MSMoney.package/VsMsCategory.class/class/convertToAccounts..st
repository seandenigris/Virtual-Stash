as yet unclassified
convertToAccounts: file
	"VsMsCategory convertToAccounts: VirtualStashDB backupDirectoryParent / 'MS Money' / 'expense categories.txt'."
	| rootCategories |
	rootCategories := VsMsCategoryListParser parse: file.
	^ rootCategories
			collect: [ :cat | 
				| children |
				children := cat children
					collect: [ :chld | 
						VsAccount new
							name: chld name;
							yourself ].
				VsAccount new
					name: cat name;
					children: children;
					yourself ]