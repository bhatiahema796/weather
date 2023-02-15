import 'package:flutter/material.dart';
import 'package:fluttericon/meteocons_icons.dart';
import 'network.dart';
import 'package:clemency/services/location.dart';
import 'location.dart';

String weatherIconUrl = 'http://openweathermap.org/img/wn/';
String weatherurl = 'https://api.openweathermap.org/data/2.5/weather';
String apikey = '11c8eb01cf64a9229f3bb4591177b5d5';
String forcast = 'http://api.openweathermap.org/data/2.5/forecast';
String fapikey = '3f26d0d5c3cb14376e042fb2e95c4312';

class Weathermodel {
  Image getweatherimages(int condition) {
    if (condition < 300) {
      return (Image(image: AssetImage('images/thunder.png')));
    } else if (condition < 400) {
      return (Image(image: AssetImage('images/10d.png')));
    } else if (condition < 600) {
      return (Image(image: AssetImage('images/raining.png')));
    } else if (condition < 700) {
      return (Image(image: AssetImage('images/13d.png')));
    } else if (condition < 800) {
      return (Image(image: AssetImage('images/fogcloud.png')));
    } else if (condition == 800) {
      return (Image(image: AssetImage('images/sun.png')));
    } else if (condition <= 804) {
      return (Image(image: AssetImage('images/cloud.png')));
    } else {
      return (Image(image: AssetImage('images/2d.png')));
    }
  }

  // now we are creating the weathers information
  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getcurrentlocation();
    Networkhelp networkhelp = Networkhelp(
        '$weatherurl?lat=${location.getlatitude()}&lon=${location.getlongitude()}&appid=$apikey&units=metric');
    var weatherdata =  networkhelp.getdata();
    return weatherdata;

  }
   Future<dynamic> getcityweather( String? cityname )async{
     Networkhelp networkhelp =
     Networkhelp('$weatherurl?q=$cityname&appid=$apikey&units=metric');
     var cityweather = await networkhelp.getdata();
     return cityweather;
   }

   Future<dynamic> getdailylocation()async{
     Location location = Location();
     await location.getcurrentlocation();
     Networkhelp networkhelp = Networkhelp(
         '$forcast?lat=${location.getlatitude()}&lon=${location.getlongitude()}&appid=$apikey&units=metric');

     var weatherlocationdata = networkhelp.getdata();
     return weatherlocationdata;
   }
  Future<dynamic> gethourweather()async{
    Location location = Location();
    await location.getcurrentlocation();
    Networkhelp networkhelp = Networkhelp(
        '$forcast?lat=${location.getlatitude()}&lon=${location.getlongitude()}&appid=$apikey&units=metric');

    var weatherlocationdata = networkhelp.getdata();
    return weatherlocationdata;
  }
  Future<dynamic> getcityhourweather(String? cityname) async {
    Location location = Location();
    await location.getcurrentlocation();
    Networkhelp networkhelp =
    Networkhelp('$forcast?q=$cityname&appid=$apikey&units=metric');
    var weathercitydata = networkhelp.getdata();
    return weathercitydata;
  }

  Future<dynamic> getcitydailyweather(String? cityname) async {
    Location location = Location();
    await location.getcurrentlocation();
   Networkhelp networkhelp =
    Networkhelp('$forcast?q=$cityname&appid=$apikey&units=metric');
    var weathercitydata = networkhelp.getdata();
    return weathercitydata;
  }

}
