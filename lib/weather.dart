class Weather {
  Weather(
      {required this.weather,
      required this.description,
      required this.temp,
      required this.minTemp,
      required this.maxTemp,
      required this.humidity});
  final String weather;
  final String description;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final int humidity;

  factory Weather.fromJson(List<dynamic> json) {
    Map<String, dynamic> mergedJson = {};
    for (var map in json) {
      mergedJson.addAll(map);
    }
    return Weather(
      weather: mergedJson['main'] as String,
      description: mergedJson['description'] as String,
      temp: mergedJson['temp'] - 273.15 as double,
      minTemp: mergedJson['temp_min'] - 273.15 as double,
      maxTemp: mergedJson['temp_max'] - 273.15 as double,
      humidity: mergedJson['humidity'] as int,
    );
  }

  @override
  String toString() => '''
*------------------------------------------------------*
  Current Forecast    : $weather
  Description         : $description
  Current Temperature : ${temp.toStringAsFixed(0)}°C
  Minimum Temperature : ${minTemp.toStringAsFixed(0)}°C
  Maximum Temperature : ${maxTemp.toStringAsFixed(0)}°C
''';
}
