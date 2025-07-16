import 'package:flutter/material.dart';

class AppConstants {
  static const String SERVER_API_URL = "http://192.168.0.107:8000/";
  static const String OPEN_FIRST_TIME_KEY = "first_time";
  static const String LOGGED_IN = "logged_in";
  static const String USER_PROFILE = "profile";
  static const String USER_TOKEN = "user_token";
  static const String INIT_FILE_APP = "isInitedFileApp";
}

class ImageRes {
  static const String _imageBasePath = "assets/images";
  static const String homeBanner1 = '$_imageBasePath/homeBanner_main.png';
  static const String homeBanner2 = '$_imageBasePath/homeBanner_media.png';
  static const String homeBanner3 = '$_imageBasePath/homeBanner_music.png';
  static const String welcomePage1 = '$_imageBasePath/reading.png';
  static const String welcomePage2 = '$_imageBasePath/music.png';
}

const kLargeTempTextStyle = TextStyle(
  fontSize: 80,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

const kSubheadingTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 20.0,
  color: Colors.black,
);

/*

Constant TextStyle values for hourly_card.dart

 */

const kHourlyCardTemperature = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);

const kHourlyCardTime = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  color: Colors.black54,
);

const kHourlyCardIcon = TextStyle(
  fontSize: 25.0,
);

/*

Constant TextStyle values for info_card.dart

 */

const kInfoCardInfoText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 20,
);

const kInfoCardTitle = TextStyle(
  color: Colors.black54,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

/*

Constant TextStyle values for saved_location_screen.dart

*/

const kSubtitleTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 16,
);

/*

Constant TextStyle values for daily_forecast_screen.dart

*/

const kTitleTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w200,
  color: Colors.white,
);

const kDateTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black54,
);

const kPanelCardMargin = EdgeInsets.all(10);

const kSubheadingTextMargin =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0);

const kBorderRadius = BorderRadius.all(Radius.circular(14.0));
