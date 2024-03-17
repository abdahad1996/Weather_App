import 'package:weatherapp/Data/Api/API_error.dart';

class RemoteWeatherModel {
  final String weatherCategory;
  final String weatherCondition;
  final String icon;

  RemoteWeatherModel(
      {required this.weatherCategory,
      required this.weatherCondition,
      required this.icon});

  factory RemoteWeatherModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['main', 'description', 'icon'])) {
      throw APIError.invalidJson;
    }
    return RemoteWeatherModel(
        weatherCategory: json['main'],
        weatherCondition: json['description'],
        icon: json['icon']);
  }
}
