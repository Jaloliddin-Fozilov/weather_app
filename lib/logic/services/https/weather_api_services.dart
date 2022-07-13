import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/data/models/weathet.dart';
import 'package:weather_app/logic/services/exceptions/weather_exceptions.dart';

class WeatherApiServices {
  final http.Client client;
  WeatherApiServices({required this.client});

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse(
        '$base_url?q=${city.toLowerCase()}&units=metric&appid=$api_key');
    try {
      final response = await client.get(url);

      if (response.statusCode >= 400) {
        throw Exception(response.reasonPhrase);
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody == null) {
        throw WeatherExceptions('Cannot get weather for $city');
      }

      final data = responseBody as Map<String, dynamic>;
      final weatherData = data['weather'][0];
      final mainData = data['main'];

      final Weather weather = Weather(
        id: weatherData['id'].toString(),
        main: weatherData['main'],
        description: weatherData['description'],
        icon: weatherData['icon'],
        temperature: double.parse(mainData['temp'].toString()),
        city: city,
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
