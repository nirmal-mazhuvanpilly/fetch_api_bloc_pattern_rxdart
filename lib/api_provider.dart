import 'dart:convert';

import 'package:fetch_api_bloc_pattern/weather_model.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  Client client = Client();

  final baseUrl =
      "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22";

  Future<WeatherModel> fetchLondonWeather() async {
    final response = await client.get(baseUrl);
    print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load Data");
    }
  }
}
