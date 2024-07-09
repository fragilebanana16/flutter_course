import 'package:flutter/foundation.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/hivedb/hive_storage.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/util/utility_functions.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class PlugInManage {
  static final PlugInManage _singleton = PlugInManage._internal();

  factory PlugInManage() {
    return _singleton;
  }

  PlugInManage._internal();

  bool _initialized = false;

  Future<void> initPlugins() async {
    if (_initialized) {
      return;
    }

    if (UtilityFunctions.isMobile) {
      // [todo]reenter makes it init twice
      await FlutterDownloader.initialize(debug: kDebugMode, ignoreSsl: true);
    }
    await HiveStorage().init();
    _initialized = true;
    // window_size configuration
    if (UtilityFunctions.isDesktop) {
      // setWindowMinSize(const Size(700, 600));
      // setWindowMaxSize(Size.infinite);
    }
  }
}
