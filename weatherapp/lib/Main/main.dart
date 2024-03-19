import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/UI/Page/weekly_forcast_page.dart';
import 'Factories/bloc/weekly_forcast_bloc_factory.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                makeWeeklyForcastBloc()..add(const OnLoadWeeklyResults(19, 29)))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeeklyForcastPage(),
      ),
    );
  }
}
