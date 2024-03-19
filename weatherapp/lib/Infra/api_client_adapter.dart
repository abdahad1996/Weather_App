import 'dart:convert';
import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Data/Api/api_client.dart';
import 'package:http/http.dart';

class ApiClientAdapter implements APIClient {
  final Client client;

  ApiClientAdapter(this.client);
  @override
  Future<dynamic> getRequest({required String url, Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      futureResponse = client.get(Uri.parse(url), headers: defaultHeaders);
      response = await futureResponse.timeout(const Duration(seconds: 10));
    } catch (error) {
      throw APIError.serverError;
    }
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw APIError.badRequest;
      case 401:
        throw APIError.unauthorized;
      case 403:
        throw APIError.forbidden;
      case 404:
        throw APIError.notFound;
      default:
        throw APIError.serverError;
    }
  }
}
