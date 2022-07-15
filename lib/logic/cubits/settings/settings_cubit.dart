import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(tempUnits: TempUnits.celcius));

  void toggleTemperature() {
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
