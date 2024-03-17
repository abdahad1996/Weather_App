import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String weatherCategory;
  final String weatherCondition;
  final String icon;

  const WeatherEntity(
      {required this.weatherCategory,
      required this.weatherCondition,
      required this.icon});

  @override
  List<Object?> get props => [weatherCategory, weatherCondition, icon];
}
