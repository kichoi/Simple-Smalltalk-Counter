utilities
baseline: spec
	<baseline>
	spec for: #common do:[
		spec
			package:'Weather-API'
	].
	spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
	