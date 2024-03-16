import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;
  final int wind;

  const WeatherEntity(
      {required this.cityName,
      required this.main,
      required this.description,
      required this.iconCode,
      required this.temperature,
      required this.pressure,
      required this.humidity,
      required this.wind});

  @override
  List<Object?> get props => throw [
        cityName,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
        wind,
      ];
}
