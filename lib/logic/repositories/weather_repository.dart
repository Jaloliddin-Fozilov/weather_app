import '../../data/models/weathet.dart';
import '../services/https/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});

  Future<Weather> getWeather(String city) async {
    return await weatherApiServices.getWeather(city);
  }
}
