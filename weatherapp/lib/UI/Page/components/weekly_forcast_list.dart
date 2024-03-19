// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'package:weatherapp/Main/Factories/api/api_url_factory.dart';
import 'package:weatherapp/UI/Helpers/extensions.dart';

class WeatherForcastList extends StatelessWidget {
  final List<WeeklyForcastEntity> weatherForcasts;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool isCelcius;

  const WeatherForcastList({
    super.key,
    required this.weatherForcasts,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isCelcius,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          height: isPortrait ? 98.0 : double.maxFinite,
          // width: double.infinity,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: orientation == Orientation.portrait
                ? Axis.horizontal
                : Axis.vertical,
            separatorBuilder: (context, index) => isPortrait
                ? const SizedBox(width: 8)
                : const SizedBox(height: 8),
            itemCount: weatherForcasts.length,
            itemBuilder: (context, index) {
              final weatherForcast = weatherForcasts[index];
              final isSelected = index == selectedIndex;
              return WeatherForcastItem(
                weatherForcast: weatherForcast,
                isSelected: isSelected,
                onTap: () {
                  onItemSelected(index);
                },
                isCelcius: isCelcius,
              );
            },
          )),
    );
  }
}

class WeatherForcastItem extends StatelessWidget {
  final WeeklyForcastEntity weatherForcast;
  final bool isSelected;
  final Function onTap;
  final bool isCelcius;

  const WeatherForcastItem({
    super.key,
    required this.weatherForcast,
    required this.isSelected,
    required this.onTap,
    required this.isCelcius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function(),
      child: Container(
        constraints: const BoxConstraints(minWidth: 64.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.blue.withOpacity(.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  DateFormat('EEE').format(weatherForcast.date),
                  style: const TextStyle(fontSize: 16.0),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 36.0,
                  width: 36.0,
                  child: Image(
                    image: NetworkImage(
                      makeWeatherIconUrl(
                        weatherForcast.weather.icon,
                      ),
                    ),
                  ),
                ),
                Text(
                  isCelcius
                      ? '${weatherForcast.temperature.tempMax.toStringAsFixed(0)}°/${weatherForcast.temperature.tempMin.toStringAsFixed(0)}°'
                      : '${weatherForcast.temperature.tempMax.toFahrenheit().toStringAsFixed(0)}°/${weatherForcast.temperature.tempMin.toFahrenheit().toStringAsFixed(0)}°',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
