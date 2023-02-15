import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:upgrader/upgrader.dart';
import 'package:clemency/services/weather.dart';
import 'locations_screen.dart';

var weatherData;
var hourData;
var dailyData;

class loadingScreen extends StatefulWidget {
  @override
  State<loadingScreen> createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocation();
  }

  Future getlocation() async {
    Weathermodel weathermodel = Weathermodel();
    weatherData = await weathermodel.getlocationweather();
    hourData = await weathermodel.gethourweather();
    dailyData = await weathermodel.getdailylocation();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return (LocationScreen(
            weatherdata: weatherData,
            hourdata: hourData,
            dailydata: dailyData,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/start.jpg'), fit: BoxFit.fill),
            ),
            child: SpinKitRing(
              color: Colors.white,
              size: 80,
              lineWidth: 5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Please wait'),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                  side: BorderSide(color: Colors.black, width: 1)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LocationScreen(
                    weatherdata: weatherData,
                    hourdata: hourData,
                    dailydata: dailyData,
                  );
                }));
              },
              child: Text(
                "Weather",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),),

        ],
      ),
    );
  }
}
