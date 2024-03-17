import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class location{

  late double latitude ;
  late double longitude ;



 Future <void>getCurentlocation( )async {
    LocationPermission permission ;
    try{
      permission  = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude ;
    longitude = position.longitude ;

    }
    catch(e){

      print(e);

    }
  }
}
