import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/services/db_service.dart';

import 'package:weather_app/features/weather/data/datasources/weather_datasources.dart';
import 'package:weather_app/features/weather/data/repo_impls/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // getItInstance.registerSingleton<LoginRepositoryImpl>(LoginRepositoryImpl());
  // getItInstance.registerSingleton<GetWeather>(GetWeather());
  // // getItInstance.registerSingleton<LoginDataResourceImplementation>(
  // //     LoginDataResourceImplementation(client: http.Client()));
  // getItInstance.registerSingleton<WeatherDataResource>(
  //     WeatherDataResourceImplementation(client: http.Client()));

  sl
    ..registerFactory(() => WeatherCubit(getWeather: sl()))
    ..registerLazySingleton(() => GetWeather(sl()))
    ..registerLazySingleton<HiveDBHandler>(() => HiveDBHandler())
    ..registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(sl()))
    ..registerLazySingleton<WeatherDataResource>(
        () => WeatherDataResourceImplementation(sl()))
    ..registerLazySingleton(http.Client.new);
}
