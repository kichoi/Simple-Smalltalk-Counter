as yet unclassified
forecastUrl: aPoint
	"return the forecast url"
	| response url aRtn |
	aRtn:= nil.
	url:= self baseUrl,(aPoint x) asString,',',(aPoint y) asString.
	response := ZnClient new 
		url: url;
		enforceHttpSuccess: true;
		accept:ZnMimeType applicationJson;
		contentReader:[:entity|NeoJSONReader fromString: entity contents];
		get.
	(response at:'properties') 
		ifNotNil: [ aRtn:=(response at:'properties') at: 'forecast'].
	^ aRtn
