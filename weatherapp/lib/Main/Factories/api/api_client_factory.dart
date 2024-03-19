import 'package:http/http.dart';
import 'package:weatherapp/Data/Api/api_client.dart';
import 'package:weatherapp/Infra/api_client_adapter.dart';

APIClient makeHttpAdapter() => ApiClientAdapter(Client());
