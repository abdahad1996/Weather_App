extension DoubleExtension on double {
  double toFahrenheit() => (this * 1.8 + 32).toDouble();
  double toCelsius() => ((this - 32) / 1.8).toDouble();
}
