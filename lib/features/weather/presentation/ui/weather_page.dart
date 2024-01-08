import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/ui/search_page.dart';
import 'package:weather_app/features/weather/presentation/ui/settings_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_empty.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_error.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_loading.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_populated.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherView();
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    context.read<WeatherCubit>().fetchWeather(18.52, 73.85, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Flutter Weather',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(context.read<WeatherCubit>()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (BuildContext context, state) {
              // if (state.status.isSuccess) {
              //   context.read<ThemeCubit>().updateTheme(state.weather);
              // }
            },
            builder: (context, WeatherState state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return WeatherPopulated(
                    weather: state.weather!,
                    units: state.temperatureUnits,
                  );
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(10, 10, city ?? '');
        },
      ),
    );
  }
}
