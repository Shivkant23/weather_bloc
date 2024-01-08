import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/errors/exceptions.dart';

import 'package:weather_app/features/weather/data/models/weather_model.dart';

const _baseUrlWeather = 'https://api.api-ninjas.com/v1';

abstract class WeatherDataResource {
  Future<WeatherModel> getWeather(
      [double? latitude, double? longitude, String? city]);
}

class WeatherDataResourceImplementation extends WeatherDataResource {
  WeatherDataResourceImplementation(this.client);

  final http.Client client;

  @override
  Future<WeatherModel> getWeather(
      [double? latitude, double? longitude, String? city]) async {
    final weatherRequest = city!.isNotEmpty
        ? Uri.parse('$_baseUrlWeather/weather?city=$city')
        : Uri.parse('$_baseUrlWeather/weather?lat=$latitude&lon=$longitude');
    const headers = {'X-Api-Key': 'lKPi6chV6M8XJwi1YtBPPg==weeywmBoBUkcb4Gr'};

    try {
      final weatherResponse =
          await client.get(weatherRequest, headers: headers);
      final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;
      if (weatherResponse.statusCode != 200) {
        throw ApiException(
            message: weatherResponse.body,
            statusCode: weatherResponse.statusCode);
      }
      return WeatherModel.fromJson(bodyJson);
    } on ApiException catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
