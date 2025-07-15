import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_enums.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/pages/music/service/weather_model.dart';
import 'package:flutter_course/pages/music/views/Widgets/weather/weather_info_card.dart';
import 'package:intl/intl.dart';
import 'package:flutter_course/global.dart';

class HourlyCard extends StatelessWidget {
  final BuildContext context;
  //the icon to show weather condition
  final String icon;
  //temp conditions
  final int temp;
  //the time of the forecast to be displayed
  final String displayTime;
  //if the forecast is for the current hour
  final bool isCurrent;
  //extra data to show when card is tapped
  final dynamic weatherData;
  //probability of precipitation
  final int pop;

  HourlyCard(
      {required this.context,
      required this.icon,
      required this.displayTime,
      required this.temp,
      this.weatherData,
      required this.pop,
      required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'View weather for the selected hour',
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
          side: BorderSide(
            color: isCurrent
                ? Colors.blueAccent.withOpacity(0.7)
                : Colors.transparent,
            width: 3.5,
          ),
        ),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: kBorderRadius,
          onTap: () {
            showInfoDialog();
          },
          child: Container(
            height: 100,
            width: 67,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  displayTime,
                  textAlign: TextAlign.center,
                  style: kHourlyCardTime.copyWith(
                      color: Theme.of(context).primaryColorDark),
                ),
                Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      icon,
                      style: kHourlyCardIcon,
                    ),
                  ),
                ),
                Text(
                  "${temp.toString()}°",
                  style: kHourlyCardTemperature.copyWith(
                      color: Theme.of(context).primaryColorLight),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.opacity_outlined,
                      size: 14,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "$pop%",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> parseData() async {
    bool imperial = await Global.storageService.getImperial();
    WindUnit unit = await Global.storageService.getWindUnit();

    double windSpeed = WeatherModel.convertWindSpeed(
        weatherData["wind"]?["speed"]?.round(), unit, imperial);
    int windDirection = weatherData["wind"]?["deg"]?.round();
    String unitString = WeatherModel.getWindUnitString(unit);
    return "${windSpeed.round()} $unitString ${WeatherModel.getWindCompassDirection(windDirection)}";
  }

  void showInfoDialog() {
    String description = weatherData["weather"][0]["description"];
    int temperature = weatherData["main"]?["temp"]?.round();
    double feelTemp = weatherData["main"]?["feels_like"]?.toDouble();
    int humidity = weatherData["main"]?["humidity"]?.round();
    int pressure = weatherData["main"]?["pressure"]?.round();
    String windValue = '';
    parseData().then((value) => windValue = value);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 300), // 控制淡入时间
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
              backgroundColor: Theme.of(context).cardColor,
              insetPadding: EdgeInsets.all(20),
              content: Container(
                width: 300,
                height: 340,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).backgroundColor,
                      ),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                icon,
                                style: kHourlyCardIcon,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: 300,
                      child: GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 2,
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          InfoCard(
                              title: "temperature", value: "$temperature°"),
                          InfoCard(title: "feelsLike", value: "$feelTemp°"),
                          InfoCard(title: "wind", value: windValue),
                          InfoCard(title: "precipitation", value: "$pop%"),
                          InfoCard(title: "humidity", value: "$humidity%"),
                          InfoCard(title: "pressure", value: "$pressure hPa"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "close",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
