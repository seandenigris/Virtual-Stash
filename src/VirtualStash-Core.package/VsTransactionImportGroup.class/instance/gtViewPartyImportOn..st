accessing
gtViewPartyImportOn: aView
	<gtView>
	^ aView explicit
		title: 'Import';
		priority: 2;
		stencil: [ self counterpartyImportElement ]