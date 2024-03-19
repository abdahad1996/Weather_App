import 'package:weatherapp/Data/Usecases/remote_load_weekly_forcast.dart';
import 'package:weatherapp/Domain/Usecases/load_weekly_forcast.dart';
import 'package:weatherapp/Main/Factories/api/api_client_factory.dart';
import 'package:weatherapp/Main/Factories/api/api_url_factory.dart';

//dortmund lat=51.5150749&lon=7.4660988
LoadWeeklyForcast makeWeeklyForcast() => RemoteLoadWeeklyForcast(
    url: makeWeatherApiUrl(51.5150749, 7.4660988), client: makeHttpAdapter());
