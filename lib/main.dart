import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/services/get_it_service.dart';
import 'package:weather_app/core/services/db_service.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/ui/weather_page.dart';
import 'package:weather_app/routes_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await initHiveDb();


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (BuildContext context) => sl<WeatherCubit>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: color),
        textTheme: GoogleFonts.rajdhaniTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      name: RoutesNames.weather,
      builder: (context, state) => const WeatherPage(),
    ),
    // GoRoute(
    //   path: '/profile:name',
    //   name: RoutesNames.profile,
    //   builder: (context, state) => Profile(name: state.pathParameters['name']!),
    //   routes: [
    //     GoRoute(
    //       path: 'profile-details',
    //       name: RoutesNames.profileDetails,
    //       builder: (context, state) =>
    //           ProfileDetails(name: state.pathParameters['name']!),
    //     ),
    //   ],
    // )
  ]);
}
