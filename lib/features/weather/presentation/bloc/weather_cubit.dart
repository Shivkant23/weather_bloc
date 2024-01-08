import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/services/db_service.dart';
import 'package:weather_app/core/services/get_it_service.dart';
import 'package:weather_app/core/services/hive_db/models/temp_model.dart';
import 'package:weather_app/features/weather/domain/entities/location.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/extentions/extentions.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required GetWeather getWeather})
      : _getWeather = getWeather,
        super(WeatherState(status: WeatherStatus.initial));

  GetWeather _getWeather;
  HiveDBHandler db = sl<HiveDBHandler>();

  Future<void> fetchWeather(
      [double? latitude, double? longitude, String? city]) async {
    try {
      emit(
        WeatherState(
          status: WeatherStatus.loading,
        ),
      );

      final hasConnected = await InternetConnectionChecker().hasConnection;

      if (hasConnected) {
        final result = await _getWeather(latitude, longitude, city);

        result.fold(
            (failure) => emit(state.copyWith(status: WeatherStatus.failure)),
            (weather) {
          final units = state.temperatureUnits;
          weather.condition = toCondition(weather.temp!);
          weather.dateTime = nowDateTime();
          weather.city = city;
          weather.location =
              Location(latitude: latitude ?? 0, longitude: longitude ?? 0);
          weather.myTemp =
              units.isFahrenheit ? toFahrenheit(weather.temp!) : toCelsius(weather.myTemp!);
          weather.maxTemp =
              (units.isFahrenheit ? toFahrenheit(weather.temp!) : toCelsius(weather.maxTemp!)) as int?;
          weather.minTemp =
              (units.isFahrenheit ? toFahrenheit(weather.temp!) : toCelsius(weather.minTemp!)) as int?;

          db.addData(
            city!.isNotEmpty ? city : 'lat:$latitude&long:$latitude',
            mapping(weather),
          );

          // TempModel weatherLocal = db.getData(city.isNotEmpty
          //     ? city
          //     : 'lat:$latitude&long:$latitude');

          emit(
            WeatherState(
              status: WeatherStatus.success,
              temperatureUnits: units,
              weather: weather,
            ),
          );
        });
      } else {
        TempModel weatherLocal = db.getData(city!.isNotEmpty
            ? city
            : 'lat:$latitude&long:$latitude');

        emit(
          WeatherState(
            status: WeatherStatus.success,
            temperatureUnits: TemperatureUnits.celsius,
            weather: mappingToWeather(weatherLocal),
          ),
        );
      }
    } catch(e) {
      print(e);
      emit(
        WeatherState(
          status: WeatherStatus.failure
        ),
      );
    }
  }

  TempModel mapping(Weather weather){
    TempModel model = TempModel();
    model.location = weather.location;
    model.city = weather.city;
    model.maxTemp = weather.maxTemp;
    model.temp = weather.temp;
    model.cloudPct = weather.cloudPct;
    model.condition = weather.condition;
    model.dateTime = weather.dateTime;
    model.feelsLike = weather.feelsLike;
    model.humidity = weather.humidity;
    model.minTemp = weather.minTemp;
    model.sunrise = weather.sunrise;
    model.sunrise = weather.sunrise;
    model.windDegrees = weather.windDegrees;
    model.windSpeed = weather.windSpeed;
    model.myTemp = weather.myTemp;
    return model;
  }

  Weather mappingToWeather(TempModel obj){
    Weather model = Weather();
    model.location = obj.location;
    model.city = obj.city;
    model.maxTemp = obj.maxTemp;
    model.temp = obj.temp;
    model.cloudPct = obj.cloudPct;
    model.condition = obj.condition;
    model.dateTime = obj.dateTime;
    model.feelsLike = obj.feelsLike;
    model.humidity = obj.humidity;
    model.minTemp = obj.minTemp;
    model.sunrise = obj.sunrise;
    model.sunrise = obj.sunrise;
    model.windDegrees = obj.windDegrees;
    model.windSpeed = obj.windSpeed;
    model.myTemp = obj.myTemp;
    return model;
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (state.status.isSuccess) {
      if (state.temperatureUnits == TemperatureUnits.fahrenheit) {
        state.weather!.myTemp = state.weather!.temp!;
      } else {
        state.weather!.myTemp = toFahrenheit(state.weather!.temp!);
      }
      emit(state.copyWith(temperatureUnits: units));
      return;
    }
  }

  WeatherCondition toCondition(int temp) {
    if (temp < 1) {
      return WeatherCondition.clear;
    } else if (temp >= 1 || temp < 49) {
      return WeatherCondition.cloudy;
    } else if (temp >= 1 || temp < 49) {
      return WeatherCondition.rainy;
    } else if (temp >= 49 || temp < 90) {
      return WeatherCondition.snowy;
    } else {
      return WeatherCondition.unknown;
    }
  }

  nowDateTime(){
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse('${DateTime.now().toUtc()}', true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  double? toFahrenheit(int i) => ((i * 9 / 5) + 32).toDouble();

  double? toCelsius(int i) => ((i - 32) * (5 / 9)).toDouble();
}
