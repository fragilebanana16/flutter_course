import 'package:flutter_course/pages/signin/notifier/sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'application_nav_notifier.g.dart';

@riverpod
class ApplicationNavIndex extends _$ApplicationNavIndex {
  @override
  int build() {
    return 0;
  }

  void changeIndex(int val) {
    state = val;
  }
}
