import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/utils/typedef.dart';
import 'package:weather_app/features/weather/data/datasources/weather_datasources.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl(this._dataResource);

  final WeatherDataResource _dataResource;

  @override
  ResultFuture<Weather> getWeather(
      [double? latitude, double? longitude, String? city]) async {
    try {
      Weather weather =
          await _dataResource.getWeather(latitude, longitude, city);

      return Right(weather);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
