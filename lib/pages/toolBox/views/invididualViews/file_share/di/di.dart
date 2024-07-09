import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/api_service.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/global_scope_data.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/hivedb/clients/shared_file_client.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/data/pref_data.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/repository/file_repository.dart';
import 'package:flutter_course/pages/toolBox/views/invididualViews/file_share/service/download_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DIManage {
  static final DIManage _singleton = DIManage._internal();

  factory DIManage() {
    return _singleton;
  }

  DIManage._internal();

  bool _initialized = false;

  void setupDI() {
    if (_initialized) {
      return;
    }
    getIt.registerSingleton<GlobalScopeData>(GlobalScopeData());
    getIt.registerSingleton<ApiService>(ApiService());
    getIt.registerSingleton<PrefData>(PrefData());
    getIt.registerSingleton<DownloadService>(DownloadService());

    // hive clients
    getIt.registerSingleton<SharedFileClient>(SharedFileClient());

    // repositories
    getIt.registerSingleton<FileRepository>(
        FileRepository(getIt.get<ApiService>()));
    _initialized = true;
  }
}
