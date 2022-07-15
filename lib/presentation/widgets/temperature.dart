import 'package:flutter/material.dart';

import '../../data/models/weathet.dart';

class Temperature extends StatelessWidget {
  const Temperature({
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
          '${weather.temperature.toStringAsFixed(0)}℃',
          style: const TextStyle(
            fontSize: 70,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.network(
                'http://openweathermap.org/img/wn/${weather.icon}.png',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              weather.main,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
