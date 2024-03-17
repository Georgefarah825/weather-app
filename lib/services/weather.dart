import 'package:climaweather/services/location.dart';
import 'package:climaweather/services/networking.dart';

const apikey = '6f84c694a567c1d2efced095f2824817';
const openweathermapurl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getcityWeather(String cityName) async {
    var url = "$openweathermapurl?q=$cityName&appid=$apikey&units=metric";

    NetworkHelper networkHelper = await NetworkHelper(url);

    var weatherData = networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getlocationweather() async {
    location loc = new location();
    await loc.getCurentlocation();

    NetworkHelper NTH = new NetworkHelper(
        "$openweathermapurl?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apikey&units=metric");

    var weatherdata = await NTH.getData();

    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
