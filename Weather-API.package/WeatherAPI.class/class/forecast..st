as yet unclassified
forecast: aPoint
	"comment stating purpose of message"	
	| response url|
	url := self forecastUrl: aPoint.
	"mapper:=NeoJSONReader new."
	response := ZnClient new
		url: url;
   		enforceHttpSuccess: true;
   		accept: ZnMimeType applicationJson;
		contentReader: [:entity| |reader|
			reader:=(NeoJSONReader on: entity readStream).
			"reader mapInstVarsFor: ForecastResponse."
			reader for: ForecastResponse do: [ :m |
				(m mapInstVar:#type).
				m mapInstVar: #geometry.
				m mapInstVar: #properties.
				
				].
			reader for: #ArrayOfForecast customDo: [ :mapping| mapping listOfElementSchema: Forecast ].
			reader mapInstVarsFor: Forecast.
			reader nextAs: ForecastResponse.
			];
		get.
		
	^ response


