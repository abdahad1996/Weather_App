import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
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
      const WeeklyForcastStateLoaded([])
    ],
  );

//TODO COME BACK TO IT LATER

  // blocTest<WeeklyForcastBloc, WeeklyForcastState>(
  //   'emits [WeatherLoading, WeatherLoaded[data]] when OnLoadWeeklyResults Event is added and results are successful',
  //   build: () {
  //     loadWeeklyForcast.mockLoad(weathers: result);

  //     return sut;
  //   },
  //   act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
  //   wait: const Duration(milliseconds: 1000),
  //   expect: () {
  //     print(sut.state);
  //     // [WeeklyForcastLoading(), WeeklyForcastStateLoaded(result)];
  //   },
  //   // errors:(matcher){

  //   // },
  // );

  blocTest<WeeklyForcastBloc, WeeklyForcastState>(
      'emits [WeatherLoading, WeatherFailure[messagye]] when OnLoadWeeklyResults Event is added and loading fails due to invalid key',
      build: () {
        // loadWeeklyForcast.mockLoadError(DomainError.invalidCredentials);
        when(() => loadWeeklyForcast.loadByCoordinates(any(), any()))
            .thenThrow(WeeklyForcastLoadingFailue("api key is missing"));
        return sut;
      },
      act: (bloc) => bloc.add(const OnLoadWeeklyResults(19, 29)),
      wait: const Duration(milliseconds: 1000),
      expect: () {
        [
          WeeklyForcastLoading(),
          WeeklyForcastLoadingFailue("api key is missing")
        ];
      });
}
