import 'dart:convert';
import 'package:weatherapp/Data/Api/API_error.dart';
import 'package:weatherapp/Data/Api/api_client.dart';
import 'package:http/http.dart';

class ApiClientAdapter implements APIClient {
  final Client client;

  ApiClientAdapter(this.client);
  @override
  Future<dynamic> getRequest({required String url}) async {
    var response = Response('', 500);
    Future<Response>? futureResponse;
    try {
      response = await client.get(Uri.parse(url));
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
