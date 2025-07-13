import 'dart:ui';
import 'package:flutter_course/common/utils/app_enums.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_weather/animation/weather_type.dart';
// import 'package:flutter_weather/constants/constants.dart';
// import 'package:flutter_weather/preferences/language.dart';
// import 'package:flutter_weather/preferences/shared_prefs.dart';
// import 'package:flutter_weather/screens/radar_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_weather/constants/text_style.dart';
// import 'package:flutter_weather/animation/weather_animation.dart';
// import 'package:flutter_weather/components/info_card.dart';
// import 'package:flutter_weather/services/time.dart';
// import 'package:flutter_weather/components/panel_card.dart';
// import 'package:flutter_weather/components/hourly_card.dart';
import '../../../service/weather_model.dart';
// import 'package:flutter_weather/services/extensions.dart';
import 'package:geolocator/geolocator.dart';
import '../../../service//time_helper.dart';
import 'package:flutter_course/global.dart';

class CurrentWeather extends StatefulWidget {
  //get the weather from loading screen
  @override
  CurrentWeather();
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  //animation for the current time / weather

  // WeatherAnimation weatherAnimation = new WeatherAnimation();
  double lat = 0.0;
  double lon = 0.0;

  DateTime weatherTime = DateTime(1900); //the time from the forecast
  DateTime sunriseTime = DateTime(1900); //sunrise
  DateTime sunsetTime = DateTime(1900); //sunset

  int timeZoneOffset = 0;
  String timeZoneOffsetText = ''; //the displayed version of timezoneoffset

  String conditionDescription = '';
  int temperature = -999; // 设置为不可能的温度值，方便识别是否已赋真实值
  double feelTemp = -999.0;
  int pressure = -1; // 正常气压为 980~1050 hPa，用 -1 做默认
  int humidity = -1; // 湿度范围为 0~100%，用 -1 表示未初始化

  double windSpeed = 0.0; //wind speed in m/s for metric, mph for imperial
  String unitString = ''; //unit for the wind speed
  int windDirection = -999; //the angle of the wind direction in degrees

  String refreshTimeText = '';
  DateTime refreshTime = DateTime(1900); //the time weather last updated

  bool isLoading = true; //if data is being loaded
  String _locationText = '尚未获取位置';

  @override
  void initState() {
    super.initState();
    // if (!(WeatherModel.weatherData == 401 ||
    //     WeatherModel.weatherData == 429 ||
    //     WeatherModel.weatherData == null)) {
    //   updateUI();
    // }
    // _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;
    print('position');
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);

    setState(() {
      _locationText =
          '纬度: ${position.latitude.toStringAsFixed(6)}\n经度: ${position.longitude.toStringAsFixed(6)}';
    });
  }

  void updateUI() async {
    var weatherData = WeatherModel.weatherData;
    print(weatherData);
    timeZoneOffset = WeatherModel.getSecondsTimezoneOffset();
    timeZoneOffsetText = timeZoneOffset.isNegative
        ? "${(timeZoneOffset / 3600).round()}"
        : "+${(timeZoneOffset / 3600).round()}";

    lat = weatherData["coord"]["lat"].toDouble();
    lon = weatherData["coord"]["lon"].toDouble();

    weatherTime =
        TimeHelper.getDateTimeSinceEpoch(weatherData["dt"], timeZoneOffset);
    sunriseTime = TimeHelper.getDateTimeSinceEpoch(
        weatherData["sys"]["sunrise"].toInt(), timeZoneOffset);
    sunsetTime = TimeHelper.getDateTimeSinceEpoch(
        weatherData["sys"]["sunset"].toInt(), timeZoneOffset);

    int conditionCode = weatherData["weather"][0]["id"];
    //update all values
    temperature = weatherData["main"]["temp"]?.round();
    print('temp is now ${temperature}');
    feelTemp = weatherData["main"]["feels_like"]?.toDouble();
    humidity = weatherData["main"]["humidity"]?.round();
    pressure = weatherData["main"]["pressure"]?.round();

    windDirection = weatherData["wind"]["deg"]?.round();

    conditionDescription = weatherData["weather"][0]["description"];

    bool imperial = await Global.storageService.getImperial();
    WindUnit unit = await Global.storageService.getWindUnit();

    windSpeed = WeatherModel.convertWindSpeed(
        weatherData["wind"]["speed"].round(), unit, imperial);
    unitString = WeatherModel.getWindUnitString(unit);

    WeatherType weatherType = WeatherModel.getWeatherType(
        sunriseTime, sunsetTime, weatherTime, conditionCode);

    //if assets are not loaded yet, set the initial weather to build
    // if (weatherAnimation.state == null) {
    //   weatherAnimation.initialWeather = weatherType;
    // } else {
    //   //else set the weather normally
    //   weatherAnimation.state.weatherWorld.weatherType = weatherType;
    // }

    refreshTimeText = TimeHelper.getReadableTime(DateTime.now());
    refreshTime = DateTime.now();

    setState(() {
      isLoading = false;
    });
  }

  //refresh data
  Future<void> refresh() async {
    print("refresh press");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("loading...")));

    if (DateTime.now().difference(refreshTime).inMinutes >= 10) {
      //if the location displayed is current, refresh location
      if (WeatherModel.locationName == "currentLocationTitle") {
        await WeatherModel.getUserLocationWeather();
      } else {
        //else refresh normally
        await WeatherModel.getCoordLocationWeather(
            latitude: lat, longitude: lon, name: WeatherModel.locationName);
        //lati, lon, WeatherModel.locationName);
      }
      updateUI();
    } else {
      refreshTimeText = TimeHelper.getReadableTime(DateTime.now());
      weatherTime = weatherTime.add(DateTime.now().difference(refreshTime));
    }

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("lastUpdatedAt $refreshTimeText")));
  }

  @override
  Widget build(BuildContext context) {
    // if (WeatherModel.weatherData == null) {
    //   return Scaffold(
    //     backgroundColor: Theme.of(context).backgroundColor,
    //     body: Center(
    //       child: Text(
    //         Language.getTranslation("chooseLocationToView"),
    //         style: TextStyle(
    //           color: Theme.of(context).backgroundColor,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        body: false
            ?
            //if is loading
            Center(
                child: Column(
                children: [
                  SpinKitFadingCircle(
                    color: Theme.of(context).primaryColorDark,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    // Language.getTranslation("loading"),
                    "loading",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            :

            //if loaded
            Stack(
                alignment: Alignment.topCenter,
                children: [
                  // weatherAnimation,
                  temperatureWidget(),
                  //infoWidget(),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "thankYouForUsing",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 85,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            //add a spacer
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.55,
                            ),
                            Column(
                              children: [
                                // createHourlyForecastCard(),
                                // createInfoCards(),
                                // radarInfoCards(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 5,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: refresh,
                        icon: Icon(
                          Icons.refresh_outlined,
                          size: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget temperatureWidget() {
    return Positioned(
      top: 5,
      left: 10,
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    // "WeatherModel.locationName",
                    _locationText,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text(
                  "${temperature.toString()}°",
                  // style: kLargeTempTextStyle,
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  conditionDescription,
                  textAlign: TextAlign.left,
                  // style: kConditionTextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                child: Text(
                  "localTime${TimeHelper.getReadableTime(weatherTime)} (UTC$timeZoneOffsetText)",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.65), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoWidget() {
    return Positioned(
      top: 90,
      right: 5,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.white,
      ),
    );
  }

  // Widget createHourlyForecastCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).backgroundColor,
  //     ),
  //     child: Container(
  //       height: 200,
  //       width: double.infinity,
  //       // margin: kPanelCardMargin,
  //       child: ListView.builder(
  //         physics: BouncingScrollPhysics(),
  //         itemBuilder: (context, index) {
  //           int temp;
  //           String icon;
  //           DateTime forecastTime;
  //           String displayTime;
  //           var weatherData;

  //           if (hourlyData[index] == null) {
  //             temp = 0;
  //             icon = "☀";
  //             displayTime = "00:00";
  //           } else {
  //             temp = hourlyData[index]["temp"].round();

  //             forecastTime = TimeHelper.getDateTimeSinceEpoch(
  //                 hourlyData[index]["dt"], timeZoneOffset);
  //             displayTime = TimeHelper.getShortReadableTime(forecastTime);

  //             DateTime tomorrowSunrise = TimeHelper.getDateTimeSinceEpoch(
  //                 dailyData[1]["sunrise"], timeZoneOffset);
  //             icon = WeatherModel.getIcon(hourlyData[index]["weather"][0]["id"],
  //                 forecastTime: forecastTime,
  //                 sunrise: sunriseTime,
  //                 sunset: sunsetTime,
  //                 tomorrowSunrise: tomorrowSunrise);
  //           }

  //           weatherData = hourlyData[index];

  //           int pop = (weatherData["pop"].toDouble() * 100)
  //               .round(); //probability of precipitation

  //           return HourlyCard(
  //             context: context,
  //             icon: icon,
  //             temp: temp,
  //             displayTime: displayTime,
  //             forecastTime: forecastTime,
  //             weatherData: weatherData,
  //             pop: pop,
  //             isCurrent: index == 0,
  //           );
  //         },
  //         scrollDirection: Axis.horizontal,
  //         shrinkWrap: true,
  //         itemCount: 24,
  //       ),
  //     ),
  //   );
  // }

  // Widget createInfoCards() {
  //   return PanelCard(
  //     cardChild: Container(
  //       color: Theme.of(context).backgroundColor,
  //       width: double.infinity,
  //       padding: kPanelCardMargin,
  //       child: GridView.count(
  //         shrinkWrap: true,
  //         childAspectRatio: 2.5,
  //         crossAxisCount: 2,
  //         physics: NeverScrollableScrollPhysics(),
  //         children: [
  //           InfoCard(
  //             title: Language.getTranslation("feelsLike"),
  //             value: "${feelTemp.toString()}°",
  //           ),
  //           InfoCard(
  //             title: Language.getTranslation("wind"),
  //             value:
  //                 "${windSpeed.round().toString()} $unitString ${WeatherModel.getWindCompassDirection(windDirection)}",
  //           ),
  //           InfoCard(
  //             title: Language.getTranslation("sunrise"),
  //             value: "${TimeHelper.getReadableTime(sunriseTime)}",
  //           ),
  //           InfoCard(
  //             title: Language.getTranslation("sunset"),
  //             value: "${TimeHelper.getReadableTime(sunsetTime)}",
  //           ),
  //           InfoCard(
  //             title: Language.getTranslation("humidity"),
  //             value: "${humidity.toString()}%",
  //           ),
  //           InfoCard(
  //             title: Language.getTranslation("pressure"),
  //             value: "${pressure.toString()} hPa",
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget radarInfoCards() {

  //   return PanelCard(
  //     cardChild: Container(
  //       color: Theme.of(context).backgroundColor,
  //       height: 140,
  //       width: double.infinity,
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 70,
  //             child: Card(
  //               child: Center(
  //                 child: ListTile(
  //                   title: Text(
  //                     Language.getTranslation("weatherRadar"),
  //                     style: TextStyle(
  //                       color: Theme.of(context).primaryColorLight,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   trailing: TextButton(
  //                     style: TextButton.styleFrom(
  //                       minimumSize: Size(50, 70),
  //                     ),
  //                     onPressed: () {
  //                       showDialog(

  //                         context: context,
  //                         builder: (BuildContext context) {
  //                           return AlertDialog(
  //                             shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
  //                             backgroundColor: Theme.of(context).cardColor,
  //                             insetPadding: EdgeInsets.all(20),
  //                             title: Center(
  //                               child: Text(
  //                                 Language.getTranslation("weatherRadarAboutTitle"),
  //                                 style: TextStyle(
  //                                   color: Theme.of(context).primaryColorLight,
  //                                 ),
  //                               ),
  //                             ),
  //                             content: Container(
  //                               width: 300,
  //                               height: 160,
  //                               child: Text(
  //                                   Language.getTranslation("weatherRadarAboutBody"),
  //                               style: TextStyle(
  //                                 color: Theme.of(context).primaryColorDark,
  //                               ),),
  //                             ),
  //                             actions: [
  //                               TextButton(
  //                                 onPressed: () {
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Text(Language.getTranslation("close"), style: TextStyle(color: Theme.of(context).primaryColorDark),),
  //                               )
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     },
  //                     child: Icon(
  //                       Icons.info_outline_rounded,
  //                       color: Theme.of(context).primaryColorDark,
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     //print("Pressed");
  //                     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                       return RadarScreen(lat, lon);
  //                     },),);
  //                   },
  //                 ),
  //               ),
  //               shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
  //               color: Theme.of(context).cardColor,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           Text("${Language.getTranslation("lastUpdatedAt")}$refreshTimeText",
  //               style: TextStyle(
  //                 color: Theme.of(context).primaryColorDark,
  //               ),),
  //           SizedBox(height: 5,),
  //           Text("($lat, $lon)",
  //             style: TextStyle(
  //               color: Theme.of(context).primaryColorDark,
  //             ),),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
