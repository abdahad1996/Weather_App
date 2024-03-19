import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:weatherapp/Domain/domain_error.dart';
import 'package:weatherapp/Presentation/weekly_forcast_bloc.dart';
import 'package:weatherapp/Presentation/weekly_forcast_event.dart';
import 'package:weatherapp/Presentation/weekly_forcast_state.dart';
import '../Domain/Mocks/weather_factory.dart';
import '../Domain/Usecases/load_weekly_forcast_spy.dart';

void main() {
  late WeeklyForcastBloc sut;
  late LoadWeeklyForcastSpy loadWeeklyForcast;
  final result = WeatherFactory.makeWeatherList();

  setUp(() {
    loadWeeklyForcast = LoadWeeklyForcastSpy();
    sut = WeeklyForcastBloc(loadWeeklyForcast);
  });

  test('initial state should be empty', () {
    expect(sut.state, WeeklyForcastEmpty());
  });

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
    'emits [WeatherLoading, WeatherLoaded[empty]] when OnLoadWeeklyResults Event is added but empty result.',
    build: () {
      loadWeeklyForcast.mockLoad(weathers: []);

      return sut;
    },
    act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeeklyForcastState>[
      WeeklyForcastLoading(),
      const WeeklyForcastStateLoaded([], 0, true)
    ],
  );

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
    'emits [WeatherLoading, WeatherLoaded[data]] when OnLoadWeeklyResults Event is added and results are successful',
    build: () {
      loadWeeklyForcast.mockLoad(weathers: result);

      return sut;
    },
    act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
    wait: const Duration(milliseconds: 1000),
    expect: () {
      return [
        WeeklyForcastLoading(),
        WeeklyForcastStateLoaded(result, 0, true)
      ];
    },
  );

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
      'emits [WeatherLoading, WeatherFailure[missing key"]] when OnLoadWeeklyResults Event is added and loading fails due to invalid key',
      build: () {
        loadWeeklyForcast.mockLoadError(DomainError.invalidCredentials);
        return sut;
      },
      act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [
          WeeklyForcastLoading(),
          const WeeklyForcastLoadingFailue("api key is missing")
        ];
      });

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
      'emits [WeatherLoading, WeatherFailure[connection error]] when OnLoadWeeklyResults Event is added and loading fails due to invalid data error',
      build: () {
        loadWeeklyForcast.mockLoadError(DomainError.invalidData);
        return sut;
      },
      act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [
          WeeklyForcastLoading(),
          const WeeklyForcastLoadingFailue(
              "We have a connection error please retry")
        ];
      });

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
      'emits [WeatherLoading, WeatherFailure[connection error]] when OnLoadWeeklyResults Event is added and loading fails due to connectivity error',
      build: () {
        loadWeeklyForcast.mockLoadError(DomainError.invalidData);
        return sut;
      },
      act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [
          WeeklyForcastLoading(),
          const WeeklyForcastLoadingFailue(
              "We have a connection error please retry")
        ];
      });

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
      'emits OnChangingTemperatureUnit event',
      build: () {
        sut.result = result;
        return sut;
      },
      act: (bloc) => bloc.add(const OnChangingTemperatureUnit(false)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [WeeklyForcastStateLoaded(result, 0, false)];
      });

  blocTest<WeeklyForcastBloc, WeeklyForcastState>('emits OnDayChanged]',
      build: () {
        sut.result = result;
        return sut;
      },
      act: (bloc) => bloc.add(const OnDayChanged(2)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        return [WeeklyForcastStateLoaded(result, 2, false)];
      });
}
