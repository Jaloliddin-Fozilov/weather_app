import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/weathet.dart';
import '../../repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<GetWeatherEvent>(_getWeather);
  }

  Future<void> _getWeather(GetWeatherEvent event, Emitter emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
