import 'package:climaweather/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:climaweather/utilities/constants.dart';
import 'package:climaweather/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatheIcon;
  late String cityNname;
  late String WeatherMessage;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationweather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatheIcon = 'error';
        cityNname = '';
        WeatherMessage = ' unable to get weather data';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      WeatherMessage = weather.getMessage(temperature);

      cityNname = weatherData['name'];

      var condition = weatherData['weather'][0]['id'];
      weatheIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          print('near me');
                          var weatherdata = await weather.getlocationweather();
                          updateUI(weatherdata);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          if (typedName != null) {
                            var weatherData =
                                await weather.getcityWeather(typedName);

                            updateUI(weatherData);
                          }
                          print(typedName);
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temperature°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          weatheIcon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "$WeatherMessage in $cityNname!",
                      textAlign: TextAlign.left,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
