import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/logic/cubits/settings/settings_cubit.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import 'package:weather_app/presentation/screens/settings_screen.dart';

import 'logic/cubits/weather/weather_cubit.dart';
import 'logic/repositories/weather_repository.dart';
import 'logic/services/https/weather_api_services.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          client: Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => WeatherCubit(
              weatherRepository: ctx.read<WeatherRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => SettingsCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Weather app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          routes: {
            SearchScreen.routName: (ctx) => SearchScreen(),
            SettingsScreen.routName: (ctx) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
