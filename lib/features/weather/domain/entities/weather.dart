import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/location.dart';

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

class Weather extends Equatable {
  double? windSpeed;
  int? windDegrees;
  int? temp;
  int? humidity;
  int? sunset;
  int? minTemp;
  int? cloudPct;
  int? feelsLike;
  int? sunrise;
  int? maxTemp;
  WeatherCondition? condition;
  DateTime? dateTime;
  String? city;
  Location? location;
  dynamic? myTemp;

  Weather.empty();

  Weather(
      {this.windSpeed,
      this.windDegrees,
      this.temp,
      this.humidity,
      this.sunset,
      this.minTemp,
      this.cloudPct,
      this.feelsLike,
      this.sunrise,
      this.maxTemp,
      this.location,
      this.condition,
      this.dateTime,
      this.city,
      this.myTemp});

  // void setCondition(WeatherCondition condition) {
  //   this.condition = condition;
  // }

  // Weather copyWith(Weather weather, WeatherCondition condition) {
  //   Weather weatherObj = weather;
  //   weatherObj.condition = condition;
  //   return weatherObj;
  // }

  @override
  List<Object?> get props => [location, condition];
}
