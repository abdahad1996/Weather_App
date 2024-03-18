// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';

import 'package:weatherapp/Domain/Usecases/load_weekly_forcast.dart';
import 'package:weatherapp/Domain/domain_error.dart';
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/Presentation/weekly_forcast_state.dart';

class WeeklyForcastBloc extends Bloc<WeeklyForcastEvent, WeeklyForcastState> {
  List<WeeklyForcastEntity> result = [];
  bool isCelcius = true;
  int currentDay = 0;

  final LoadWeeklyForcast loadWeeklyForcast;

  WeeklyForcastBloc(
    this.loadWeeklyForcast,
  ) : super(WeeklyForcastEmpty()) {
    mapStateToEvents();
  }

  void mapStateToEvents() {
    on<WeeklyForcastEvent>((event, emit) async {
      if (event is OnLoadWeeklyResults) {
        await loadWeeklyResults(emit, event);
      }

      if (event is OnChangingTemperatureUnit) {
        // emit()
        isCelcius = !isCelcius;
        emit(WeeklyForcastStateLoaded(result, currentDay, isCelcius));
      }

      if (event is OnDayChanged) {
        currentDay = event.index;
        emit(WeeklyForcastStateLoaded(result, currentDay, isCelcius));
      }
    });
  }

  Future<void> loadWeeklyResults(
      Emitter<WeeklyForcastState> emit, OnLoadWeeklyResults event) async {
    emit(WeeklyForcastLoading());
    try {
      result = await loadWeeklyForcast.loadByCoordinates(event.lat, event.long);
      emit(WeeklyForcastStateLoaded(result, 0, isCelcius));
    } catch (error) {
      if (error == DomainError.invalidCredentials) {
        emit(const WeeklyForcastLoadingFailue("api key is missing"));
        return;
      }
      emit(const WeeklyForcastLoadingFailue(
          "We have a connection error please retry"));
    }
  }
}
