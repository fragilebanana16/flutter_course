import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future getData() async {
    try {
      http.Response response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        //if the response is successful
        String data = response.body;
        //return decoded data
        return jsonDecode(data);
      } else if (response.statusCode == 429) {
        //if the response is unsuccessful
        return 429;
      } else if (response.statusCode == 401) {
        //if the response is unsuccessful
        return 401;
      }
    } on SocketException catch (_) {
    } on TimeoutException catch (_) {}
    return null;
  }

  Future<dynamic> getMockData() async {
    // 模拟返回固定天气数据
    return {
      "coord": {"lon": 108.89, "lat": 34.27},
      "weather": [
        {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
      ],
      "base": "stations",
      "main": {
        "temp": 40.62,
        "feels_like": 40.27,
        "temp_min": 40.62,
        "temp_max": 40.62,
        "pressure": 999,
        "humidity": 20,
        "sea_level": 999,
        "grnd_level": 955
      },
      "visibility": 10000,
      "wind": {"speed": 2.13, "deg": 37, "gust": 2.95},
      "clouds": {"all": 3},
      "dt": 1752398664,
      "sys": {"country": "CN", "sunrise": 1752356522, "sunset": 1752407872},
      "timezone": 28800,
      "id": 2001378,
      "name": "Weiyanggong",
      "cod": 200
    };
  }
}
