api
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
			reader for: ForecastResponse do: [ :m |
				(m mapInstVar:#type).
				m mapInstVar: #geometry.
				(m mapInstVar: #properties) valueSchema:#ForecastSchema.
				].
			reader for: #ForecastSchema do: [ :m|
				m subjectClass: Forecast.
				m mapInstVars.
				(m mapInstVar: #periods) valueSchema: #ArrayOfForecast.
				 ].
			reader for: #ArrayOfForecast customDo: [ :mapping| mapping listOfElementSchema: ForecastPeriod ].
			reader mapInstVarsFor: ForecastPeriod.
			reader nextAs: ForecastResponse.
			];
		get.
		
	^ response


