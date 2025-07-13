import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_course/common/utils/app_enums.dart';

class StorageService {
  late final SharedPreferences _pref;
  Future<StorageService> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool isFirstOpened() {
    return _pref.getBool(AppConstants.OPEN_FIRST_TIME_KEY) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getBool(AppConstants.LOGGED_IN) ?? false;
  }

  UserProfile getUserProfile() {
    var profile = _pref.getString(AppConstants.USER_PROFILE) ?? "";
    var profileJson = jsonDecode(profile);
    var userEntity = UserProfile.fromJson(profileJson);
    return userEntity;
  }

  String getUserToken() {
    return _pref.getString(AppConstants.USER_TOKEN) ?? "";
  }

  // 位置
  static const String defaultLocationKey = "defaultLocationKey";

  Future<List> getDefaultLocation() async {
    List<String>? location = _pref.getStringList(defaultLocationKey);

    if (location != null) {
      return [
        location[0],
        double.parse(location[1]),
        double.parse(location[2])
      ];
    }
    return ["Use a default location on app startup."];
  }

  Future<void> setDefaultLocation(
      {required String text, required double lat, required double long}) async {
    await _pref.setStringList(
        defaultLocationKey, [text, lat.toString(), long.toString()]);
  }

  Future<void> removeDefaultLocation() async {
    await _pref.remove(defaultLocationKey);
  }

  // 单位制 Imperial英制华氏， metric公制摄氏
  static const String imperialKey = "useImperial";
  Future<bool> getImperial() async {
    //if value is none return false
    bool value = _pref.getBool(imperialKey) ?? false;
    return value;
  }

  Future<void> setImperial(bool newValue) async {
    await _pref.setBool(imperialKey, newValue);
  }

  // 风速
  static const String windKey = "windUnit";
  Future<WindUnit> getWindUnit() async {
    WindUnit unit = WindUnit.values[_pref.getInt(windKey) ?? 0];
    return unit;
  }

  Future<void> setWindUnit(WindUnit unit) async {
    await _pref.setInt(windKey, unit.index);
  }

  // openWeatherKey api key
  static const String owmKey = "openWeatherKey";
  Future<String> getOpenWeatherAPIKey() async {
    String code = _pref.getString(owmKey) ?? "";
    return code;
  }

  Future<void> setOpenWeatherAPIKey(String key) async {
    await _pref.setString(owmKey, key);
    print(key.toString());
  }

  // 24h制
  static const String h24key = "use24h";

  Future<bool> get24() async {
    //if value is none return false
    bool value = _pref.getBool(h24key) ?? true;
    return value;
  }

  Future<void> set24(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _pref.setBool(h24key, newValue);
  }
}
