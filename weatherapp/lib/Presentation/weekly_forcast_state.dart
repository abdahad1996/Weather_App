import 'package:equatable/equatable.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';

abstract class WeeklyForcastState extends Equatable {
  const WeeklyForcastState();

  @override
  List<Object?> get props => [];
}

class WeeklyForcastEmpty extends WeeklyForcastState {}

class WeeklyForcastLoading extends WeeklyForcastState {}

class WeeklyForcastStateLoaded extends WeeklyForcastState {
  final List<WeeklyForcastEntity> result;

  const WeeklyForcastStateLoaded(this.result);
  @override
  String toString() => 'WeeklyForcastStateLoaded { todos: $result }';
  @override
  List<Object?> get props => [result];
}

class WeeklyForcastLoadingFailue extends WeeklyForcastState {
  final String message;

  const WeeklyForcastLoadingFailue(this.message);

  @override
  List<Object?> get props => [message];
}
