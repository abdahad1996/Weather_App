import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Data/Api/api_client.dart';
import 'package:weatherapp/Data/Model/remote_weekly_forcast_model.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'package:weatherapp/Domain/Usecases/load_weekly_forcast.dart';
import 'package:weatherapp/Domain/domain_error.dart';

class RemoteLoadWeeklyForcast implements LoadWeeklyForcast {
  final String url;
  final APIClient client;

  RemoteLoadWeeklyForcast({required this.url, required this.client});

  @override
  Future<List<WeeklyForcastEntity>> loadByCoordinates(
      double latitude, double longitude) async {
    try {
      final json = await client.getRequest(url: url);
      List<WeeklyForcastEntity> weeklyForcasts = mapper(json);
      return weeklyForcasts;
    } on APIError catch (error) {
      if (error == APIError.unauthorized) {
        return throw DomainError.invalidCredentials;
      }
      if (error == APIError.invalidJson) {
        return throw DomainError.invalidData;
      }
      return throw DomainError.notConnected;
    }
  }

  List<WeeklyForcastEntity> mapper(json) {
    try {
      final dailyForcastJson = json['daily'];
      List<WeeklyForcastEntity> weeklyForcasts = dailyForcastJson
          .map<WeeklyForcastEntity>(
              (item) => RemoteWeeklyForcastModel.fromJson(item).toEntity())
          .toList();
      if (weeklyForcasts.isEmpty) {
        return [];
      } else {
        return weeklyForcasts;
      }
    } catch (error) {
      return throw DomainError.invalidData;
    }
  }
}

extension MapListExtension on List<Map<dynamic, dynamic>> {
  List<dynamic> getValuesForKey(dynamic key) {
    List<dynamic> values = [];
    for (var map in this) {
      if (map.containsKey(key)) {
        values.add(map[key]);
      }
    }
    return values;
  }
}
