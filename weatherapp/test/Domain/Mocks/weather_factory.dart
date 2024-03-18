import 'package:weatherapp/Domain/Entities/temperature_entity.dart';
import 'package:weatherapp/Domain/Entities/weather_entity.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';

class WeatherFactory {
  static WeeklyForcastEntity makeWeather({int dt = 1710586800}) {
    final time = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
    const temp =
        TemperatureEntity(temp: 292.87, tempMax: 294.25, tempMin: 290.47);
    const weather = WeatherEntity(
        weatherCategory: "clear", weatherCondition: "clear sky", icon: "01n");
    final entity = WeeklyForcastEntity(
        date: time,
        temperature: temp,
        weather: weather,
        pressure: 1019,
        humidity: 70,
        wind: 6.26);
    return entity;
  }

  static List<WeeklyForcastEntity> makeWeatherList() => [
        makeWeather(dt: 1710673200),
        makeWeather(dt: 1710759600),
        makeWeather(dt: 1710846000),
        makeWeather(dt: 1710932400),
        makeWeather(dt: 1711018800),
        makeWeather(dt: 1711105200),
        makeWeather(dt: 1711191600),
      ];
}
