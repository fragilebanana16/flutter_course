import 'dart:convert';

import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;
  Future<StorageService> init() async {
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
}
