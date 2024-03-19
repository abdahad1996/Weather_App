// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'package:weatherapp/Main/Factories/api/api_url_factory.dart';
import 'package:weatherapp/UI/Helpers/extensions.dart';

class WeeklyForcastTodayWidget extends StatelessWidget {
  final WeeklyForcastEntity weatherForcast;
  final bool isCelcius;

  const WeeklyForcastTodayWidget({
    super.key,
    required this.weatherForcast,
    required this.isCelcius,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              DateFormat('EEEE').format(weatherForcast.date),
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            weatherForcast.weather.weatherCondition,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: double.infinity, // Expand to fill the width
                  height: 300,
                  child: FittedBox(
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          makeWeatherIconUrl(
                            weatherForcast.weather.icon,
                          ),
                        ) // Rectangular image placeholder
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              isCelcius
                  ? "${weatherForcast.temperature.temp.toStringAsFixed(0)}°C"
                  : "${weatherForcast.temperature.temp.toFahrenheit().toStringAsFixed(0)}°F",
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Humidity: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    "${weatherForcast.humidity}%",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Pressure: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    "${weatherForcast.pressure} hPa",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Wind: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(
                    "${weatherForcast.wind} km/h",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  TextStyle get bold {
    return const TextStyle(fontWeight: FontWeight.bold);
  }

  TextSpan operator +(TextStyle textStyle) {
    return TextSpan(text: this, style: textStyle);
  }
}

extension BoldText on String {
  Widget makeBoldText() {
    return Text(
      this,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
