// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Presentation/weekly_forcast_bloc.dart';
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/Presentation/weekly_forcast_state.dart';
import 'package:weatherapp/UI/Components/retry_widget.dart';
import 'package:weatherapp/UI/Components/temperature_metric_switcher.dart';
import 'package:weatherapp/UI/Page/components/weekly_forcast_list.dart';
import 'package:weatherapp/UI/Page/components/weekly_forcast_today.dart';

class WeeklyForcastPage extends StatelessWidget {
  const WeeklyForcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Weekly Forcast',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<WeeklyForcastBloc, WeeklyForcastState>(
          builder: (context, state) {
            if (state is WeeklyForcastEmpty) {
              //retry
              return const Center(
                child: Text("data is empty "),
              );
            }
            if (state is WeeklyForcastLoading) {
              return const Center(
                child: CircularProgressIndicator(
                    key: ValueKey('CircularProgressIndicator')),
              );
            }
            if (state is WeeklyForcastStateLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<WeeklyForcastBloc>()
                      .add(const OnLoadWeeklyResults(0, 0));
                },
                child: ListView(children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Dortmund",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          TemperatureSwitcher(
                            isCelsius: state.isCelcius,
                            onSwitch: () => context
                                .read<WeeklyForcastBloc>()
                                .add(OnChangingTemperatureUnit(
                                    !state.isCelcius)),
                          ),
                        ],
                      ),
                      WeeklyForcastTodayWidget(
                        key: const Key('WeeklyForcastTodayWidget'),
                        weatherForcast: state.result[state.currentDay],
                        isCelcius: state.isCelcius,
                      ),
                      WeatherForcastList(
                        key: const Key('WeatherForcastList'),
                        weatherForcasts: state.result,
                        selectedIndex: state.currentDay,
                        onItemSelected: ((index) => context
                            .read<WeeklyForcastBloc>()
                            .add(OnDayChanged(index))),
                        isCelcius: state.isCelcius,
                      ),
                    ],
                  ),
                ]),
              );
            }
            if (state is WeeklyForcastLoadingFailue) {
              //failure message + retry
              return RetryWidget(
                  error: state.message,
                  reload: () => context
                      .read<WeeklyForcastBloc>()
                      .add(const OnLoadWeeklyResults(0, 0)));
            }
            return Container(
              color: Colors.red,
            );
          },
        ));
  }
}
