import 'package:equatable/equatable.dart';

class TemperatureEntity extends Equatable {
  final double temp;
  final double tempMax;
  final double tempMin;

  const TemperatureEntity(
      {required this.temp, required this.tempMax, required this.tempMin});

  @override
  List<Object?> get props => [temp, tempMax, tempMin];
}
