import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_controller.g.dart';

// combine provider and control together
@riverpod
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
