
// Clase para representar los datos de una estación de radio
class RadioFM {
  final String changeuuid;
  final String stationuuid;
  final String name;
  final String url;
  final String urlResolved;
  final String homepage;
  final String favicon;
  final String tags;
  final String country;
  final String countrycode;
  final String state;
  final String language;
  final String languagecodes;
  final String codec;
  final int bitrate;

  RadioFM({
    required this.changeuuid,
        required this.stationuuid,
        required this.name,
        required this.url,
        required this.urlResolved,
        required this.homepage,
        required this.favicon,
        required this.tags,
        required this.country,
        required this.countrycode,
        required this.state,
        required this.language,
        required this.languagecodes,
        required this.codec,
        required this.bitrate,
  });
}

// Lista de estaciones de radio
final List<RadioFM> radioFMList = [
  RadioFM(
    changeuuid: "30ab2c13-6038-4895-85a6-1dec17ec8444",
    stationuuid: "963ccae5-0601-11e8-ae97-52543be04c81",
    name: "Deutschlandfunk [MP3 128k]",
    url: "http://st01.dlf.de/dlf/01/128/mp3/stream.mp3",
    urlResolved: "http://f121.rndfnk.com/ard/dlf/01/mp3/128/stream.mp3?cid=01FBPWZ12X2XN8SDSMBZ7X0ZTT&sid=2eAuBMLzUj0IUKWD5Fu7IKhre7V&token=VELDeNgXSsEdAgdQMCZZe9Qo4S44Zqn-L1-WyGDym-I&tvf=5Zs9jRoMwBdmMTIxLnJuZGZuay5jb20",
    homepage: "http://www.deutschlandfunk.de/",
    favicon: "http://www.deutschlandfunk.de/static/img/deutschlandfunk/icons/apple-touch-icon-128x128.png",
    tags: "cultural news,culture,information,kultur,news",
    country: "Germany",
    countrycode: "DE",
    state: "",
    language: "german",
    languagecodes: "de",
    codec: "MP3",
    bitrate: 128,
  ),
   RadioFM(
changeuuid: "8125d095-6397-4660-a5c4-ef0254f67e06",
stationuuid: "9617a958-0601-11e8-ae97-52543be04c81",
name: "Radio Paradise (320k)",
url: "http://stream-uk1.radioparadise.com/aac-320",
urlResolved: "http://stream-uk1.radioparadise.com/aac-320",
homepage: "https://www.radioparadise.com/",
favicon: "https://www.radioparadise.com/favicon-32x32.png",
tags: "california,eclectic,free,internet,non-commercial,paradise,radio",
country: "The United States Of America",
countrycode: "US",
state: "California",
language: "english",
languagecodes: "en",
codec: "AAC",
bitrate: 320,
  ),
  // Puedes agregar más estaciones de radio aquí...
];
