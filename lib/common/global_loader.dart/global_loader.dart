import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'global_loader.g.dart';

@riverpod
class Apploader extends _$Apploader {
  @override
  bool build() {
    return false;
  }

  void setLoaderValue(bool value) {
    state = value;
  }
}
