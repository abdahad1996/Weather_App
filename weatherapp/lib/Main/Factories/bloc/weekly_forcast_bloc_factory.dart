import 'package:weatherapp/Main/Factories/usecases/load_weekly_forcast_factory.dart';
import 'package:weatherapp/Presentation/weekly_forcast_bloc.dart';

WeeklyForcastBloc makeWeeklyForcastBloc() =>
    WeeklyForcastBloc(makeWeeklyForcast());
