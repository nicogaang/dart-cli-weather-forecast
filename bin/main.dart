import 'dart:io';

import 'package:dart_cli_weather_forecast/weather_api_client.dart';

Future<void> main() async {
  stdout.write('Search for City : ');
  final city = stdin.readLineSync().toString();
  final api = WeatherApiClient();
  try {
    final weather = await api.fetchWeather(city);
    print(weather);
  } on WeatherApiException catch (e) {
    print(e.message);
  } on SocketException catch (_) {
    print(
        'Could not fetch data from weather API. Please check your internet connection');
  } catch (e) {
    print(e);
  }
}
