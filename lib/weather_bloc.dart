import 'package:fetch_api_bloc_pattern/repository.dart';
import 'package:fetch_api_bloc_pattern/weather_model.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  Repository _repository = Repository();

  final _weatherFetcher = PublishSubject<WeatherModel>();

  Observable<WeatherModel> get weather => _weatherFetcher.stream;
  Sink<WeatherModel> get weatherAdd => _weatherFetcher.sink;

  fetchLondonWeather() async {
    WeatherModel weatherResponse = await _repository.fetchLondonWeather();
    weatherAdd.add(weatherResponse);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();
