import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/logic/repositories/weather_repository.dart';
import 'package:weather_app/logic/services/https/weather_api_services.dart';

import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeatherData();
  }

  void _getWeatherData() async {
    final weatherRep = WeatherRepository(
      weatherApiServices: WeatherApiServices(
        client: Client(),
      ),
    );
    final weather = await weatherRep.getWeather('chirchiq');
    print(weather.temperature);
    print(weather.main);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
