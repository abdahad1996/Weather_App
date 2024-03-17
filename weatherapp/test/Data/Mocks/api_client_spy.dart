import 'package:mocktail/mocktail.dart';
import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Data/Api/api_client.dart';

class APIClientSpy extends Mock implements APIClient {
  When mockGetRequestCall() => when(() => getRequest(
        url: any(named: 'url'),
      ));
  void mockRequest(dynamic data) =>
      mockGetRequestCall().thenAnswer((_) async => data);
  void mockRequestError(APIError error) =>
      mockGetRequestCall().thenThrow(error);
}
