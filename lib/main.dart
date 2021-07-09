import 'package:fetch_api_bloc_pattern/weather_bloc.dart';
import 'package:fetch_api_bloc_pattern/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'API Fetch Bloc Pattern'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    weatherBloc.fetchLondonWeather();
    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildWeatherScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Container _buildWeatherScreen(WeatherModel data) {
    return Container(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTitle(data.name),
          _buildCoord(data.coord),
          _buildMain(data.main),
          _buildWindInfo(data.wind),
          _buildSys(data.sys),
        ],
      ),
    );
  }

  Center _buildTitle(String name) {
    return Center(
      child: Text(
        "Weather in " + name,
        style: TextStyle(color: Colors.red, fontSize: 40.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _buildCoord(Coord coord) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Coord",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Lat: " + coord.lat.toString()),
            _buildVerticalDivider(),
            Text("Lng: " + coord.lon.toString())
          ],
        ),
      ],
    );
  }

  Column _buildMain(Main main) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Main",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Text("Temperature: " + main.temp.toString()),
        Text("Pressure: " + main.pressure.toString()),
        Text("Humidity: " + main.humidity.toString()),
        Text("Highest temperature: " + main.tempMax.toString()),
        Text("Lowest temperature: " + main.tempMin.toString()),
      ],
    );
  }

  Column _buildWindInfo(Wind wind) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Wind",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Speed: " + wind.speed.toString()),
            _buildVerticalDivider(),
            Text("Degree: " + wind.deg.toString()),
          ],
        )
      ],
    );
  }

  Container _buildVerticalDivider() {
    return Container(
        height: 20, child: VerticalDivider(color: Colors.blueGrey));
  }

  Column _buildSys(Sys sys) {
    final dateFormat = new DateFormat('hh:mm:ss');

    var sunriseDate =
        new DateTime.fromMillisecondsSinceEpoch(sys.sunrise * 1000);
    var sunsetDate = new DateTime.fromMillisecondsSinceEpoch(sys.sunset * 1000);
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Sys",
            style: TextStyle(
                color: Color.fromRGBO(0, 123, 174, 100), fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Sunrise: " + dateFormat.format(sunriseDate)),
            _buildVerticalDivider(),
            Text("Sunset: " + dateFormat.format(sunsetDate)),
          ],
        ),
      ],
    );
  }
}
