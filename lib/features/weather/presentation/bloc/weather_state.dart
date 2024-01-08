import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/extentions/extentions.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

// abstract class WeatherState {}

class WeatherState {
  WeatherState({
    required this.status,
    this.temperatureUnits = TemperatureUnits.celsius,
    this.weather,
  });

  final WeatherStatus status;
  final Weather? weather;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      status: this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }
}



// final class WeatherState extends Equatable {
//   WeatherState({
//     this.status = WeatherStatus.initial,
//     this.temperatureUnits = TemperatureUnits.celsius,
//     Weather? weather,
//   }) : weather = weather ?? Weather.empty;

//   final WeatherStatus status;
//   final Weather weather;
//   final TemperatureUnits temperatureUnits;

//   WeatherState copyWith({
//     WeatherStatus? status,
//     TemperatureUnits? temperatureUnits,
//     Weather? weather,
//   }) {
//     return WeatherState(
//       status: status ?? this.status,
//       temperatureUnits: temperatureUnits ?? this.temperatureUnits,
//       weather: weather ?? this.weather,
//     );
//   }

//   @override
//   List<Object?> get props => [status, temperatureUnits, weather];
// }
