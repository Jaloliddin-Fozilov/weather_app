import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weathet.dart';
import 'package:weather_app/logic/cubits/cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import '../../helpers/extensions/string_extensions.dart';
import '../widgets/city.dart';
import '../widgets/temperature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather('Chirchiq');
  }

  void _getWeather(String city) {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) async {
          if (state is WeatherError) {
            await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  )
                ],
              ),
            );
            _getWeather('Chirchiq');
          }
        },
        builder: (ctx, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: Text('Select a city'),
            );
          }
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherLoaded) {
            final weather = state.weather;
            String mainWeather = weather.main.toLowerCase();
            String imagePath = '';
            if (mainWeather.contains('sun')) {
              imagePath = 'assets/sunny.jpg';
            } else if (mainWeather.contains('cloud')) {
              imagePath = 'assets/cloudy.jpg';
            } else if (mainWeather.contains('rain')) {
              imagePath = 'assets/rainy.jpg';
            } else {
              imagePath = 'assets/night.jpg';
            }
            return Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned(
                  right: 0,
                  top: 40,
                  child: IconButton(
                    onPressed: () async {
                      final _city = await Navigator.of(context)
                          .pushNamed(SearchScreen.routName);
                      if (_city != null) {
                        _getWeather(_city as String);
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        City(weather: weather),
                        Temperature(weather: weather),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
