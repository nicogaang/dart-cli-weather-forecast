import 'dart:convert';
import 'package:dart_cli_weather_forecast/weather.dart';
import 'package:dart_cli_weather_forecast/cities.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';

class WeatherApiException implements Exception {
  const WeatherApiException(this.message);
  final String message;
}

class WeatherApiClient {
  final apikey = apiKey();
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/';

  Future<Weather> fetchWeather(String line) async {
    final city = Cities().getCity(line);
    final location = city[0];
    final lat = city[2];
    final lng = city[3];
    final weatherUrl =
        Uri.parse('$baseUrl/weather?lat=$lat&lon=$lng&appid=$apikey');
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw WeatherApiException('Error getting weather for $location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    final weather = weatherJson['weather'] as List;
    List<dynamic> main = [weatherJson['main']];
    List<dynamic> mergedJson = [...weather, ...main];
    if (mergedJson.isEmpty) {
      throw WeatherApiException('Weather data is not available for $location');
    }
    return Weather.fromJson(mergedJson);
  }
}

String? apiKey() {
  final env = DotEnv(includePlatformEnvironment: true)..load();
  final apiKey = env['API_KEY'];
  return apiKey;
}
