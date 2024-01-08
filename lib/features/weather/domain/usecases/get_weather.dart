import 'package:equatable/equatable.dart';
import 'package:weather_app/core/services/get_it_service.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/core/utils/typedef.dart';
import 'package:weather_app/features/weather/data/datasources/weather_datasources.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

class GetWeather {
  GetWeather(this.weatherRepository);
  WeatherRepository weatherRepository;

  ResultFuture<Weather> call([double? latitude, double? longitude, String? city]) async{
    return await weatherRepository.getWeather(latitude, longitude, city);
  }
}

// class GetWeatherParams extends Equatable {
//   double? latitude;
//   double? longitude;
//   String? city;
//
//   GetWeatherParams(
//       {required this.latitude, required this.longitude, required this.city});
//
//   @override
//   List<Object?> get props => [latitude, longitude, city];
// }
