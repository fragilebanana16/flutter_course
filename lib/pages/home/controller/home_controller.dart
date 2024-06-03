import 'package:flutter/material.dart';
import 'package:flutter_course/common/api/video_api.dart';
import 'package:flutter_course/common/models/user.dart';
import 'package:flutter_course/common/models/video_entity.dart';
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

@Riverpod(keepAlive: true)
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}

@Riverpod(keepAlive: true)
class HomeVideoList extends _$HomeVideoList {
  Future<List<VideoItem>?> fetchVideoList() async {
    var res = await VideoAPI.videoList();
    if (res.code == 200) {
      return res.data;
    }

    return null;
  }

  @override
  FutureOr<List<VideoItem>?> build() {
    return fetchVideoList(); // A type representing values that are either Future<T> or T.
  }
}
