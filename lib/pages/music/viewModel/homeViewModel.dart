import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final txtSearch = TextEditingController().obs;

  final hostRecommendedArr = [
    {
      "image": "assets/images/img_1.png",
      "name": "Sound of Sky",
      "artists": "Dilon Bruce"
    },
    {
      "image": "assets/images/img_2.png",
      "name": "Girl on Fire",
      "artists": "Alecia Keys"
    }
  ].obs;

  final playListArr = [
    {
      "image": "assets/images/img_3.png",
      "name": "Classic Playlist",
      "artists": "Piano Guys"
    },
    {
      "image": "assets/images/img_4.png",
      "name": "Summer Playlist",
      "artists": "Dilon Bruce"
    },
    {
      "image": "assets/images/img_5.png",
      "name": "Pop Music",
      "artists": "Michael Jackson"
    }
  ];

  final recentlyPlayedArr = [
    {"rate": 4, "name": "Billie Jean", "artists": "Michael Jackson"},
    {"rate": 4, "name": "Earth Song", "artists": "Michael Jackson"},
    {"rate": 4, "name": "Mirror", "artists": "Justin Timberlake"},
    {"rate": 4, "name": "Remember the Time", "artists": "Michael Jackson"}
  ].obs;
}

//.navigationViewStyle(StackNavigationViewStyle())