import 'package:clemency/screens/loading_screen.dart';
import 'package:clemency/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'setting.dart';
import 'package:clemency/utilites/items.dart';
import 'package:clemency/utilites/weatherinformation.dart';

String weathericonurl =
    "http://openweathermap.org/img/wn/"; // to get the icon from the openweatherapi icon

class LocationScreen extends StatefulWidget {
  LocationScreen(
      {required this.weatherdata,
      required this.hourdata,
      required this.dailydata});

  final weatherdata;
  final hourdata;
  final dailydata;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Weathermodel weathermodel = Weathermodel();
  final TextEditingController _controller =
      TextEditingController(); // this will help to control the text in the textfeild.

  bool showSpinner = false;

  // ignore: prefer_typing_uninitialized_variables
  var decodedData;
  List Date = [];
  List conditionlist = [];
  List Day = [];
  var temperature;
  var condition;
  var cityName;
  var msg;
  var weatherIcon;
  var newTemp;
  var dailytemp;
  List Iconlist = [];
  List dailydescription = [];

  int day = DateTime.now().weekday;
  int date = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  String? monthWord;

  String? dayWord;

  var getFeelsLike;
  int? feelsLike;
  var visibility;
  int? pressure;
  var getMaxTemp;
  int? maxTemp;
  var windSpeed;
  int? humidity;
  double? visibilityValue;
  String? typedCity;
  String? newTypedCity;
  List<String> items = ['1', '2', '3', '4', '5'];
  List hourlyDataList = [];

  List tempList = [];
  List iconList = [];
  List<String> dateList = [];
  var dailyweather;
  List<Items>? _data1 = [];

  List dailyMinTempList = [];
  String? description;
  List dailyMaxTempList = [];
  List dailydescrp = [];

  List<String> dailyIconList = [];
  List<int> dailyEpochDateList = [];
  List dailyDataList = [];
  int? dailySize;
  List<int> dailyWeekDayDateList = [];
  List<int> dailyDateList = [];
  List<int> dailyMonthDateList = [];
  List dailyHumidity = [];
  List dailyDescription = [];
  List dailyPressure = [];
  List dailyFeelslike = [];
  List dailywind = [];
  var minTemp;
  List dailytemprature = [];
  var getMinTemp;

  var weekday = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday'
  };

  var weekday1 = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun'
  };
  var monthValue = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {
      setState(() {});
    });
    UpdateUi(widget.weatherdata);
    updateHourlyData(widget.hourdata);
    updatedailydata(widget.dailydata);
  }

  void updatedailydata(dynamic dailydata) {
    setState(() {
      dailyDataList = dailydata['list'];
      int dailySize = dailyDataList.length;
      for (int i = 0; i < dailySize; i++) {
        dailyMinTempList.add(dailydata['list'][i]['main']['temp_min']);
        dailytemprature.add(dailydata['list'][i]['main']['temp']);

        dailyMaxTempList.add(dailydata['list'][i]['main']['temp_max']);

        dailyIconList.add(dailydata['list'][i]['weather'][0]['icon']);
        dailyEpochDateList.add(dailydata['list'][i]['dt']);

        dailyDateList.add(
            DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
                .day
                .toInt());

        Date = dailyDateList.toSet().toList();

        dailyWeekDayDateList.add(
            DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
                .weekday
                .toInt());

        Day = dailyWeekDayDateList.toSet().toList();
        dailyMonthDateList.add(
            DateTime.fromMillisecondsSinceEpoch(dailyEpochDateList[i] * 1000)
                .month
                .toInt());
        conditionlist.add(dailydata['list'][i]['weather'][0]['id']);
        iconList.add(weathermodel.getweatherimages(conditionlist[i]));

        dailyHumidity.add(dailydata['list'][i]['main']['humidity']);
        dailywind.add(dailydata['list'][i]['wind']['speed']);
        dailyPressure.add(dailydata['list'][i]['main']['pressure']);
        dailyFeelslike.add(dailydata['list'][i]['main']['feels_like']);
        dailydescription.add(dailydata['list'][i]['weather'][0]['description']);
      }
    });
  }

  void UpdateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        newTemp = 0;
        weatherIcon = 'Error';
        msg = 'Unable to get weather data';
        cityName = '';
        feelsLike = 0;
        visibilityValue = 0;
        pressure = 0;
        maxTemp = 0;
        windSpeed = 0;
        humidity = 0;
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherdata['name'];
      getFeelsLike = weatherdata['main']['feels_like'];
      feelsLike = getFeelsLike.toInt();
      condition =
          weatherdata['weather'][0]['id']; // here we get the condition of the
      monthWord = monthValue[month];
      dayWord = weekday[day];
      description = weatherdata['weather'][0]['description'];
      year = year;
      visibility = weatherdata['visibility'];
      visibilityValue = visibility / 1000;
      pressure = weatherdata['main']['pressure'];
      getMaxTemp = weatherdata['main']['temp_max'];
      getMinTemp = weatherdata['main']['temp_min'];

      maxTemp = getMaxTemp.toInt();
      minTemp = getMinTemp.toInt();
      msg = weatherdata['weather'][0]['main'];

      windSpeed = weatherdata['wind']['speed'];
      humidity = weatherdata['main']['humidity'];
      weatherIcon = weathermodel.getweatherimages(condition);
      showSpinner = false;
      // we are setting the value of the spinner false to make visibility  of it false.
    });
  }

  void updateHourlyData(dynamic hourlyData) {
    setState(() {
      hourlyDataList = hourlyData['list'];
      int hourlySize = hourlyDataList.length;

      for (int i = 0; i < hourlySize; i++) {
        tempList.add(hourlyData['list'][i]['main']['temp']);
        iconList.add(hourlyData['list'][i]['weather'][0]['icon']);
        String date = hourlyData['list'][i]['dt_txt'];
        date = date.substring(11, 16);
        dateList.add(date);
        dailydescrp.add(hourlyData['list'][i]['weather'][0]['description']);
      }
    });
  }

  void refreshData() async {
    setState(() {
      UpdateUi(widget.weatherdata);

      dailydescription = [];
      conditionlist = [];

      dailytemprature = [];
      dateList = [];
      dailyDescription = [];
      dailyFeelslike = [];
      dailyHumidity = [];
      dailyMaxTempList = [];
      dailyMinTempList = [];
      Day = [];
      Date = [];
      dailyMonthDateList = [];
      dailyWeekDayDateList = [];
      updatedailydata(widget.dailydata);
      tempList = [];
      iconList = [];
      tempList = [];
      dateList = [];
      updateHourlyData(widget.hourdata);

      _controller.clear();
    });
  }

  void searchcity() async {
    var weatherdata = await weathermodel.getcityweather(typedCity);
    var dhourweather = await weathermodel.getcityhourweather(typedCity);
    var dcityweather = await weathermodel.getcitydailyweather(typedCity);
    UpdateUi(weatherdata);

    dailydescription = [];
    conditionlist = [];

    dailytemprature = [];
    dateList = [];
    dailyDescription = [];
    dailyFeelslike = [];
    dailyHumidity = [];
    dailyMaxTempList = [];
    dailyMinTempList = [];
    Day = [];
    Date = [];
    dailyMonthDateList = [];
    dailyWeekDayDateList = [];

    updatedailydata(dcityweather);
    iconList = [];
    tempList = [];
    dateList = [];
    dailydescrp = [];
    updateHourlyData(dhourweather);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const SpinKitCubeGrid(
        color: Colors.black,
        size: 25.0,
      ),
      inAsyncCall: showSpinner,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: 350,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken),
                    image: AssetImage('images/background.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.0),
                    bottomRight: Radius.circular(28.0)),
              ),
              child: Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 100, left: 20, right: 20),
                    child: TextField(
                      showCursor: true,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.name,
                      controller: _controller,
                      onChanged: (value) {
                        typedCity = value;
                      },
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _controller.text.isEmpty
                                ? Container(
                                    width: 0.0,
                                    height: 0.0,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      _controller.clear();
                                    },
                                    icon: const Icon(Icons.close_sharp,
                                        color: Colors.white),
                                  ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  searchcity();
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            Container(
                              child: IconButton(
                                  onPressed: () async {
                                    refreshData();
                                  },
                                  icon: Icon(Icons.refresh_outlined,
                                      color: Colors.white)),
                            )
                          ],
                        ),
                        hintText: 'Search City',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 1.0),
              child: SizedBox(
                height: 10,
                width: 10,
                child: OverflowBox(
                  minWidth: 0.0,
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 0.0,
                  maxHeight: (MediaQuery.of(context).size.height / 4),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        height: double.infinity,
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0, right: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    Text(
                                      cityName.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontFamily: 'Barlow',
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      DateFormat(" EEE, dd MMM")
                                          .format(DateTime.now()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w200,
                                            fontFamily: 'Barlow',
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              //  here we are just calling the divider for
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          '$description',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: 'Barlow',
                                                  fontSize: 18),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '$temperature°C',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                fontSize: 38,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Barlow',
                                                color: Colors.black54,
                                              ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                            'min:${minTemp}°C / max:${maxTemp}°C',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: 'Barlow',
                                                  fontWeight: FontWeight.w500,
                                                ))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 95,
                                        padding: const EdgeInsets.only(
                                            right: 10.0, bottom: 2),
                                        child: weathermodel
                                            .getweatherimages(condition),
                                      ),
                                      Text(
                                        'wind:$windSpeed km/h',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontFamily: 'Barlow',
                                              fontWeight: FontWeight.w500,
                                            ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Container(
                                height: 75,
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 10, top: 20),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  height: 40.0,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, builder) {
                                        return const VerticalDivider(
                                          color: Colors.transparent,
                                          width: 3,
                                        );
                                      },
                                      itemCount: 9,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(0, 2),
                                                  blurRadius: 10,
                                                  color: Colors.white)
                                            ],
                                          ),
                                          width: 160,
                                          height: 100,
                                          child: Expanded(
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text('${dateList[index]}'),
                                                    Image(
                                                      image: NetworkImage(
                                                          '$weatherIconUrl${iconList[index]}@4x.png',
                                                          scale: 4),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          '${tempList[index].toInt()}°C ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Barlow',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        Text(
                                                          '${dailydescrp[index]} ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black87,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Barlow',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Next Five Days',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontFamily: 'Barlow',
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              height: 150.0,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, builder) {
                                  return const VerticalDivider(
                                    color: Colors.transparent,
                                    width: 6,
                                  );
                                },
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 10,
                                            color: Colors.white)
                                      ],
                                    ),
                                    width: 140,
                                    height: 150,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${weekday1[Day[index]]},${Date[index]}${monthValue[dailyMonthDateList[index]]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                  fontFamily: 'Barlow',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${dailytemprature[index].toInt()}°C ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                  fontFamily: 'Barlow',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 70,
                                            padding: const EdgeInsets.only(
                                                right: 10.0, bottom: 10),
                                            child:
                                                weathermodel.getweatherimages(
                                                    conditionlist[index]),
                                          ),
                                          Text(
                                            '${dailydescription[index]} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                  fontFamily: 'Barlow',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
