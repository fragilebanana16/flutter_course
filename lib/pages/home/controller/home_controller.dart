import 'package:flutter/material.dart';
import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/global.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_controller.g.dart';

// combine provider and control together
@Riverpod(keepAlive: true)
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

@riverpod
class HomeUserProfile extends _$HomeUserProfile {
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}
