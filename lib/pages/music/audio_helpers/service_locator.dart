import 'package:audio_service/audio_service.dart';
import 'package:flutter_course/pages/music/audio_helpers/audio_handler.dart';
import 'package:flutter_course/pages/music/audio_helpers/page_manager.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
