import 'dart:io';

class Cities {
  var cityDetails = [];
  List<dynamic> getCity(String city) {
    final inputSrc = 'src/worldcities.csv';
    final lines = File(inputSrc).readAsLinesSync();
    lines.removeAt(0);
    for (var line in lines) {
      final values = line.split(',');
      final formattedValues = values[0].replaceAll('"', '');
      final formattedCity =
          city[0].toUpperCase() + city.substring(1).toLowerCase();
      if (formattedValues == formattedCity) {
        cityDetails = [
          values[0].replaceAll('"', ''),
          values[4].replaceAll('"', ''),
          values[2].replaceAll('"', ''),
          values[3].replaceAll('"', ''),
        ];
        break;
      }
    }
    if (cityDetails.isEmpty) {
      throw Exception(
          'No available data for $city or maybe $city is not a city.');
    }
    return cityDetails;
  }
}
