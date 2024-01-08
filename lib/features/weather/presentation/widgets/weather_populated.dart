import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/extentions/extentions.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    required this.weather,
    required this.units,
    // required this.onRefresh,
    super.key,
  });

  final Weather weather;
  final TemperatureUnits units;
  // final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            children: [
              _WeatherIcon(condition: weather.condition!),
              sizedBox(),
              Text(
                weather.city!.isNotEmpty
                    ? '${weather.city!.toUpperCase()}'
                    : 'Lat: ${weather.location!.latitude}, Lon: ${weather.location!.longitude}',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              sizedBox(),
              Text(
                '${weather.dateTime}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w200,
                  fontSize: 22,
                  color: Colors.white
                ),
              ),
              sizedBox(),
              Text(
                'Temp: ${weather.myTemp} ${weather.formattedTemperature(units)}',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w200,
                    color: Colors.white
                ),
              ),
              sizedBox(),
              Text(
                'MinTemp: ${weather.minTemp} ${weather.formattedTemperature(units)}',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w200,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              sizedBox(),
              Text(
                'MaxTemp: ${weather.maxTemp} ${weather.formattedTemperature(units)}',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w200,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              // Text(
              //   '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
              // ),
            ],
          ),
        ),
      ),
    );
  }

  sizedBox(){
    return const SizedBox(height: 15,);
  }

  dateTimeChange(String dateUtc){
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    var dateLocal = dateTime.toLocal();

  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''°${units.isCelsius ? 'C' : 'F'}''';
  }
}
