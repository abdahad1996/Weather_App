class ApiFactory {
  static Map makeWeeklyForcastJson() => {
        'daily': [
          {
            'dt': 1710586800,
            "temp": {
              "day": 9.14,
              "min": 6.32,
              "max": 11.56,
            },
            "pressure": 1019,
            "humidity": 65,
            "wind_speed": 4.52,
            "weather": [
              {"main": "Rain", "description": "light rain", "icon": "10d"}
            ]
          },
          {
            'dt': 1710586800,
            "temp": {
              "day": 19.14,
              "min": 16.32,
              "max": 21.56,
            },
            "pressure": 1319,
            "humidity": 66,
            "wind_speed": 4.59,
            "weather": [
              {"main": "clear", "description": "clear sky", "icon": "01n"}
            ]
          }
        ],
      };

  static Map makeInvalidJson() => {'invalid_key': 'invalid_value'};
  static Map makeEmptyDailyList() => {'daily': []};

  static List<Map> makeInvalidList() => [makeInvalidJson(), makeInvalidJson()];
}
