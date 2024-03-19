import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Domain/Entities/temperature_entity.dart';
import 'package:weatherapp/Domain/Entities/weather_entity.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'remote_temperature_model.dart';
import 'remote_weather_model.dart';

class RemoteWeeklyForcastModel {
  final int date;
  final RemoteTemperatureModel temperature;
  final RemoteWeatherModel weather;
  final int pressure;
  final int humidity;
  final double wind;

  const RemoteWeeklyForcastModel(
      {required this.date,
      required this.temperature,
      required this.weather,
      required this.pressure,
      required this.humidity,
      required this.wind});

  factory RemoteWeeklyForcastModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(
        ['dt', 'temp', 'weather', 'humidity', 'wind_speed', 'pressure'])) {
      throw APIError.invalidJson;
    }
    return RemoteWeeklyForcastModel(
      date: json['dt'],
      temperature: RemoteTemperatureModel.fromJson(json['temp']),
      weather: RemoteWeatherModel.fromJson(json['weather'][0]),

      // weather: json['weather'].map<RemoteWeatherModel>(
      //     (weatherJson) => RemoteWeatherModel.fromJson(weatherJson)),
      pressure: json['pressure'],
      humidity: json['humidity'],
      wind: json['wind_speed'].toDouble(),
    );
  }

  WeeklyForcastEntity toEntity() => WeeklyForcastEntity(
      date: DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: true),
      temperature: TemperatureEntity(
          temp: temperature.temp,
          tempMax: temperature.tempMax,
          tempMin: temperature.tempMin),
      weather: WeatherEntity(
          weatherCategory: weather.weatherCategory,
          weatherCondition: weather.weatherCondition,
          icon: weather.icon),
      pressure: pressure,
      humidity: humidity,
      wind: wind);
}
