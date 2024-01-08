import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/entities/location.dart';

part 'temp_model.g.dart';

@HiveType(typeId: 1)
class TempModel extends Equatable {
  @HiveField(0)
  double? windSpeed;
  @HiveField(1)
  int? windDegrees;
  @HiveField(2)
  int? temp;
  @HiveField(3)
  int? humidity;
  @HiveField(4)
  int? sunset;
  @HiveField(5)
  int? minTemp;
  @HiveField(6)
  int? cloudPct;
  @HiveField(7)
  int? feelsLike;
  @HiveField(8)
  int? sunrise;
  @HiveField(9)
  int? maxTemp;
  @HiveField(10)
  WeatherCondition? condition;
  @HiveField(11)
  DateTime? dateTime;
  @HiveField(12)
  String? city;
  @HiveField(13)
  Location? location;
  @HiveField(14)
  dynamic? myTemp;

  TempModel.empty();

  TempModel(
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
