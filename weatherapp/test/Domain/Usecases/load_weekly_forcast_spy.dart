import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'package:weatherapp/Domain/Usecases/load_weekly_forcast.dart';
import 'package:weatherapp/Domain/domain_error.dart';

class LoadWeeklyForcastSpy extends Mock implements LoadWeeklyForcast {
  When makeLoadCall() => when(() => loadByCoordinates(any(), any()));
  void mockLoad({required List<WeeklyForcastEntity> weathers}) =>
      makeLoadCall().thenAnswer((_) async => weathers);
  void mockLoadError(DomainError error) => makeLoadCall().thenThrow(error);
}
