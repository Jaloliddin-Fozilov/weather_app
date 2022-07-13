class WeatherExceptions implements Exception {
  final String message;

  WeatherExceptions(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
