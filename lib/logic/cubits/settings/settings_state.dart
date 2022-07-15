part of 'settings_cubit.dart';

enum TempUnits {
  celcius,
  fahrenheit,
}

@immutable
class SettingsState {
  final TempUnits? tempUnits;

  const SettingsState({this.tempUnits});
}
