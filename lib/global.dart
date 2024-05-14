import 'package:flutter_course/common/services/storage.dart';

class Global {
  static late StorageService storageService;

  static Future init() async {
    storageService = await StorageService().init();
  }
}
