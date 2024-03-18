// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class WeeklyForcastEvent extends Equatable {
  const WeeklyForcastEvent();

  @override
  List<Object> get props => [];
}

class OnLoadWeeklyResults extends WeeklyForcastEvent {
  final double lat;
  final double long;

  const OnLoadWeeklyResults(
    this.lat,
    this.long,
  );
}

class OnDayChanged extends WeeklyForcastEvent {
  final int index;

  const OnDayChanged(this.index);

  @override
  List<Object> get props => [index];
}

class OnRetry extends WeeklyForcastEvent {
  const OnRetry();

  @override
  List<Object> get props => [];
}

class OnChangingTemperatureUnit extends WeeklyForcastEvent {
  final bool isCelcius;
  const OnChangingTemperatureUnit(this.isCelcius);

  @override
  List<Object> get props => [isCelcius];
}
