import 'dart:async';

import 'package:weather_app/core/utils/typedef.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  ResultFuture<Weather> getWeather(
      [double? latitude, double? longitude, String? city]);
}
