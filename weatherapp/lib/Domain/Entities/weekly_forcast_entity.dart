import 'package:equatable/equatable.dart';
import 'temperature_entity.dart';
import 'weather_entity.dart';

class WeeklyForcastEntity extends Equatable {
  final DateTime date;
  final TemperatureEntity temperature;
  final WeatherEntity weather;
  final int pressure;
  final int humidity;
  final double wind;

  const WeeklyForcastEntity(
      {required this.date,
      required this.temperature,
      required this.weather,
      required this.pressure,
      required this.humidity,
      required this.wind});

  @override
  List<Object?> get props => [
        date,
        temperature,
        weather,
        pressure,
        humidity,
        wind,
      ];
}
