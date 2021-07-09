import 'package:fetch_api_bloc_pattern/api_provider.dart';
import 'package:fetch_api_bloc_pattern/weather_model.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();
  Future<WeatherModel> fetchLondonWeather() async {
    return await _apiProvider.fetchLondonWeather();
  }
}
