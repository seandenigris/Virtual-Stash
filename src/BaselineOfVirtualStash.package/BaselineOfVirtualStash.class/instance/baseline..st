baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Aconcagua' with: [
				spec repository: 'github://seandenigris/aconcagua:denigris' ];
			baseline: 'Magritte' with: [ 
				spec 
					repository: 'github://seandenigris/Magritte';
					loads: #(#default #'Magritte-Money') ];
			baseline: 'MyPeople' with: [ spec repository: 'github://seandenigris/My-People' ];
			baseline: 'NeoCSV' with: [ 
				spec 
					repository: 'github://seandenigris/NeoCSV';
					loads: #('magritte') ];
			baseline: 'PetitParser2' with: [
				spec repository: 'github://seandenigris/PetitParser2' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimplePersistence' with: [ spec repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://seandenigris/Mocketry' ].
		spec
			package: 'Aconcagua-Money'; "Just temporary until it stabilizes and we can merge back into Aconcagua"
			package: 'VirtualStash-Core' with: [
				spec requires: #('Aconcagua' 'Aconcagua-Money' 'Magritte' 'Mocketry' 'MyPeople' 'NeoCSV' 'PetitParser2' 'PharoEnhancements' 'ResourcesLive' 'SimplePersistence') ] ].
				
	spec for: #notGToolkit do: [
		spec baseline: 'XMLParser' with: [
				spec repository: 'github://seandenigris/XML-XMLParser' ].
		spec 
			package: 'VirtualStash-Core' with: [ 
				spec requires: 'XMLParser' ] ]
