// ignore_for_file: unnecessary_brace_in_string_interps

String makeWeatherIconUrl(String iconCode) =>
    'http://openweathermap.org/img/wn/$iconCode@2x.png';
String makeWeatherApiUrl(double latitude, double longitude) =>
    'https://api.openweathermap.org/data/2.5/onecall?lat=${latitude}&lon=${longitude}&units=metric&exclude=minutely,current&appid=cc95d932d5a45d33a9527d5019475f2c';
