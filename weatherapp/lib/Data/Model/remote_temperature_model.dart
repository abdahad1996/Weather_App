import 'package:weatherapp/Data/Api/API_error.dart';

class RemoteTemperatureModel {
  final double temp;
  final double tempMax;
  final double tempMin;

  const RemoteTemperatureModel(
      {required this.temp, required this.tempMax, required this.tempMin});

  factory RemoteTemperatureModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['day', 'min', 'max'])) {
      throw APIError.invalidJson;
    }
    return RemoteTemperatureModel(
        temp: json['day'], tempMax: json['min'], tempMin: json['max']);
  }
}
