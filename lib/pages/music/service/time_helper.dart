import 'package:intl/intl.dart';
import 'package:flutter_course/global.dart';

class TimeHelper {
  static bool use24H = true;

  static void initialize() async {
    use24H = await Global.storageService.get24();
  }

  static String getReadableTime(DateTime time) {
    initialize();
    return use24H ? DateFormat.Hm().format(time) : DateFormat.jm().format(time);
  }

  //get shorthand version, ie 6PM
  static String getShortReadableTime(DateTime time) {
    initialize();
    return use24H ? DateFormat.Hm().format(time) : DateFormat.j().format(time);
  }

  static DateTime getDateTimeSinceEpoch(
      int secondsSinceEpoch, int secondsTimezoneOffset) {
    //convert from seconds to milliseconds
    int millisecondsSinceEpoch = secondsSinceEpoch * 1000;
    int millisecondsTimezoneOffset = secondsTimezoneOffset * 1000;
    //print(now.millisecondsSinceEpoch);
    //print(millisecondsTimezoneOffset);
    //print(millisecondsSinceEpoch);

    //apply the offset to the epoch time to get the correct time
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (millisecondsSinceEpoch + millisecondsTimezoneOffset),
        isUtc: true);
    //print(dateTime);

    //return the datetime object
    return dateTime;
  }

  static String getWeekdayAsString(int weekday) {
    //get the week day name from ISO 8601 weekday number
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Sunday";
    }
  }
}
