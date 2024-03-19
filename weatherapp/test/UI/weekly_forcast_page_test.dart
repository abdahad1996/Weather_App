import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/Domain/Entities/weekly_forcast_entity.dart';
import 'package:weatherapp/Main/main.dart';
import 'package:weatherapp/Presentation/weekly_forcast_bloc.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:test/test.dart' as test;
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/Presentation/weekly_forcast_state.dart';
import 'package:weatherapp/UI/Page/weekly_forcast_page.dart';

import '../Domain/Mocks/weather_factory.dart';
import '../Domain/Usecases/load_weekly_forcast_spy.dart';

class MockWeeklyForcastBloc
    extends MockBloc<WeeklyForcastEvent, WeeklyForcastState>
    implements WeeklyForcastBloc {}

void main() {
  late MockWeeklyForcastBloc bloc;
  final result = WeatherFactory.makeWeatherList();

  test.setUp(() {
    bloc = MockWeeklyForcastBloc();
    HttpOverrides.global = null;
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeeklyForcastBloc>(
      create: (context) => bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  flutter_test.testWidgets(
    "should show empty text when state is empty",
    (flutter_test.WidgetTester tester) async {
      // loadWeeklyForcast.mockLoad(weathers: result);
      when(() => bloc.state).thenReturn(WeeklyForcastEmpty());

      await tester.pumpWidget(_makeTestableWidget(const WeeklyForcastPage()));

      // await tester.tap(find.byKey(const Key("plus_button")));
      // debugDumpApp();
      flutter_test.expect(flutter_test.find.text("data is empty "),
          flutter_test.findsOneWidget);
    },
  );

  flutter_test.testWidgets(
    'should show progress indicator when state is loading',
    (flutter_test.WidgetTester tester) async {
      when(() => bloc.state).thenReturn(WeeklyForcastLoading());

      await tester.pumpWidget(_makeTestableWidget(const WeeklyForcastPage()));

      flutter_test.expect(flutter_test.find.byType(CircularProgressIndicator),
          flutter_test.findsOneWidget);
    },
  );

  flutter_test.testWidgets(
    'should show retry button when state is failed loading',
    (flutter_test.WidgetTester tester) async {
      when(() => bloc.state)
          .thenReturn(const WeeklyForcastLoadingFailue("connection error"));

      await tester.pumpWidget(_makeTestableWidget(const WeeklyForcastPage()));

      flutter_test.expect(flutter_test.find.text("connection error"),
          flutter_test.findsOneWidget);
      flutter_test.expect(flutter_test.find.byType(ElevatedButton),
          flutter_test.findsOneWidget);
    },
  );

  flutter_test.testWidgets(
    'should show widget contain WeatherForcastList and WeeklyForcastTodayWidget when state is loaded',
    (flutter_test.WidgetTester tester) async {
      when(() => bloc.state)
          .thenReturn(WeeklyForcastStateLoaded(result, 0, true));

      await tester.pumpWidget(_makeTestableWidget(const WeeklyForcastPage()));
      await tester.pump(const Duration(seconds: 5));

      // debugDumpApp();
      flutter_test.expect(
          flutter_test.find.byKey(const Key('WeatherForcastList')),
          flutter_test.findsOneWidget);

      flutter_test.expect(
          flutter_test.find.byKey(const Key('WeeklyForcastTodayWidget')),
          flutter_test.findsOneWidget);
    },
  );
}
