import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/weathet.dart';
import '../../logic/blocs/settings/settings_bloc.dart';

class Temperature extends StatefulWidget {
  const Temperature({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  String _showTemp(double temp) {
    final tempUnit = context.watch<SettingsBloc>().state.tempUnits;
    if (tempUnit == TempUnits.fahrenheit) {
      return '${(temp * 9 / 5 + 32).toStringAsFixed(0)}℉';
    }
    return '${temp.toStringAsFixed(0)}℃';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showTemp(widget.weather.temperature),
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
                'http://openweathermap.org/img/wn/${widget.weather.icon}.png',
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.weather.main,
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
