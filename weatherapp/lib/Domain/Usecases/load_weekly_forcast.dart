import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';

abstract class LoadWeeklyForcast {
  Future<List<WeeklyForcastEntity>> loadByCoordinates(
      double latitude, double longitude);
}
