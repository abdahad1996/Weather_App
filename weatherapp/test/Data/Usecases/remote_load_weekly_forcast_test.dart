import 'package:test/test.dart';
import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Data/Usecases/remote_load_weekly_forcast.dart';
import 'package:weatherapp/Domain/Entities/temperature_entity.dart';
import 'package:weatherapp/Domain/Entities/weather_entity.dart';
import 'package:weatherapp/Domain/domain_error.dart';
import '../../infra/mocks/api_factory.dart';
import '../Mocks/api_client_spy.dart';

void main() {
  late RemoteLoadWeeklyForcast sut;
  late String url;
  late APIClientSpy httpClient;
  late Map list;

  setUp(() {
    list = ApiFactory.makeWeeklyForcastJson();
    url = "http://any-url.com";
    httpClient = APIClientSpy();
    httpClient.mockRequest(list);

    sut = RemoteLoadWeeklyForcast(url: url, client: httpClient);
  });

  // test("should call http client with correct vales", () async {
  //   await sut.loadByCoordinates(10, 20);
  //   verify(() => httpClient.getRequest(url: url));
  // });

  test('Should throw notConnected if HttpClient returns 404', () async {
    httpClient.mockRequestError(APIError.notFound);

    final future = sut.loadByCoordinates(10, 4);

    expect(future, throwsA(DomainError.notConnected));
  });

  test('Should throw api key error if HttpClient returns 401', () async {
    httpClient.mockRequestError(APIError.unauthorized);

    final future = sut.loadByCoordinates(10, 4);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should throw invalidData if HttpClient returns 200 with invalid json',
      () async {
    httpClient.mockRequest(ApiFactory.makeInvalidList());

    final future = sut.loadByCoordinates(10, 4);

    expect(future, throwsA(DomainError.invalidData));
  });

  test('Should return weekly forcasts on 200', () async {
    httpClient.mockRequest(ApiFactory.makeWeeklyForcastJson());
    final givenWeeklyForcasts = list;

    final expectedWeeklyForcasts = await sut.loadByCoordinates(10, 4);

    expect(
        expectedWeeklyForcasts[0].date,
        DateTime.fromMillisecondsSinceEpoch(list["daily"][0]['dt'] * 1000,
            isUtc: true));
    expect(expectedWeeklyForcasts[0].pressure,
        givenWeeklyForcasts["daily"][0]['pressure']);
    expect(expectedWeeklyForcasts[0].wind,
        givenWeeklyForcasts["daily"][0]['wind_speed']);
    expect(expectedWeeklyForcasts[0].humidity,
        givenWeeklyForcasts["daily"][0]['humidity']);

    expect(
        expectedWeeklyForcasts[0].weather,
        WeatherEntity(
            weatherCategory: givenWeeklyForcasts["daily"][0]['weather'][0]
                ["main"],
            weatherCondition: givenWeeklyForcasts["daily"][0]['weather'][0]
                ["description"],
            icon: givenWeeklyForcasts["daily"][0]['weather'][0]["icon"]));

    expect(
        expectedWeeklyForcasts[0].temperature,
        TemperatureEntity(
            temp: givenWeeklyForcasts["daily"][0]["temp"]["day"],
            tempMax: givenWeeklyForcasts["daily"][0]["temp"]["min"],
            tempMin: givenWeeklyForcasts["daily"][0]["temp"]["max"]));
  });

  test('Should return no forcasts on 200 when empty weekly list', () async {
    httpClient.mockRequest(ApiFactory.makeEmptyDailyList());

    final expectedWeeklyForcasts = await sut.loadByCoordinates(10, 4);

    expect(expectedWeeklyForcasts, []);
  });
}
