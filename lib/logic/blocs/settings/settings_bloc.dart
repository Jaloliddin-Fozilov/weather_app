import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState(tempUnits: TempUnits.celcius)) {
    on<ToggleTempEvent>(_toggleTemperature);
  }

  void _toggleTemperature(ToggleTempEvent event, Emitter<SettingsState> emit) {
    if (state.tempUnits == TempUnits.celcius) {
      emit(
        const SettingsState(
          tempUnits: TempUnits.fahrenheit,
        ),
      );
    } else {
      emit(
        const SettingsState(
          tempUnits: TempUnits.celcius,
        ),
      );
    }
  }
}
