import 'package:flutter/material.dart';
import 'package:weather_app/helpers/extensions/string_extensions.dart';

import '../../data/models/weathet.dart';

class City extends StatelessWidget {
  const City({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city.capitalizeString(),
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weather.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
