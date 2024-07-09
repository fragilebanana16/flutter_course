import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/entity/shared_file_entity.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/entity/shared_file_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
  }

  void _registerAdapters() {
    Hive.registerAdapter(SharedFileStateAdapter());
    Hive.registerAdapter(SharedFileAdapter());
  }
}
