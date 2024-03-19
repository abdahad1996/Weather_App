import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Infra/api_client_adapter.dart';
import '../mocks/client_spy.dart';

void main() {
  late ApiClientAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = ApiClientAdapter(client);
  });

  setUpAll(() {
    url = "http://any-url.com";
    registerFallbackValue(Uri.parse(url));
  });

  group('get', () {
    test('Should call get with correct values', () async {
      await sut.getRequest(url: url);
      verify(() => client.get(Uri.parse(url)));

      await sut.getRequest(
        url: url,
      );
      verify(() => client.get(Uri.parse(url)));
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.getRequest(url: url);

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if get returns 200 with no data', () async {
      client.mockGet(200, body: '');

      final response = await sut.getRequest(url: url);

      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      client.mockGet(204, body: '');

      final response = await sut.getRequest(url: url);

      expect(response, null);
    });

    test('Should return null if get returns 204 with data', () async {
      client.mockGet(204);

      final response = await sut.getRequest(url: url);

      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      client.mockGet(400, body: '');

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      client.mockGet(400);

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.badRequest));
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      client.mockGet(401);

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.unauthorized));
    });

    test('Should return ForbiddenError if get returns 403', () async {
      client.mockGet(403);

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.forbidden));
    });

    test('Should return NotFoundError if get returns 404', () async {
      client.mockGet(404);

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.notFound));
    });

    test('Should return ServerError if get returns 500', () async {
      client.mockGet(500);

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.serverError));
    });

    test('Should return ServerError if get throws', () async {
      client.mockGetError();

      final future = sut.getRequest(url: url);

      expect(future, throwsA(APIError.serverError));
    });
  });
}
