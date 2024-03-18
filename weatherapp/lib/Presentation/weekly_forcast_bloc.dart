// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/Domain/Usecases/load_weekly_forcast.dart';
import 'package:weatherapp/Domain/domain_error.dart';
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/Presentation/weekly_forcast_state.dart';

class WeeklyForcastBloc extends Bloc<WeeklyForcastEvent, WeeklyForcastState> {
  final LoadWeeklyForcast loadWeeklyForcast;

  WeeklyForcastBloc(
    this.loadWeeklyForcast,
  ) : super(WeeklyForcastEmpty()) {
    on<WeeklyForcastEvent>((event, emit) async {
      if (event is OnLoadWeeklyResults) {
        emit(WeeklyForcastLoading());
        try {
          final result =
              await loadWeeklyForcast.loadByCoordinates(event.lat, event.long);
          emit(WeeklyForcastStateLoaded(result));
        } catch (error) {
          if (error == DomainError.invalidCredentials) {
            emit(const WeeklyForcastLoadingFailue("api key is missing"));
          }

          if (error == DomainError.invalidData) {
            emit(const WeeklyForcastLoadingFailue(
                "Some sort of connection error please retry"));
          }

          if (error == DomainError.notConnected) {
            emit(const WeeklyForcastLoadingFailue(
                "Some sort of connection error please retry"));
          }
        }
      }
    });
  }
}
