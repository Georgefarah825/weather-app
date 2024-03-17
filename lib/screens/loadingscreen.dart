





import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:climaweather/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';
import 'package:climaweather/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


double? longtude;
double? latitude;

  @override
  void initState(){
    super.initState();
getlocationdata();


  }

//video002getlocationMethod
  void getlocationdata() async {

    WeatherModel wethermodel = WeatherModel();


    var weatherdata = await wethermodel.getlocationweather();



Navigator.push(context, MaterialPageRoute(builder: (context){
  return LocationScreen(locationweather: weatherdata,);

}));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(child:
  SpinKitDoubleBounce(
    color: Colors.white,
    size: 100.0,
  )
  ,),
    );
  }
}
