import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_course/pages/music/audio_helpers/mediaitem_converter.dart';
import 'package:flutter_course/pages/music/audio_helpers/page_manager.dart';
import 'package:flutter_course/pages/music/audio_helpers/service_locator.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

DateTime playerTapTime = DateTime.now();
bool get isProcessForPlay {
  return DateTime.now().difference(playerTapTime).inMilliseconds > 600;
}

Timer? debounce;

List<Map<String, Object?>> CreateListVM(
    AsyncSnapshot<List<SongModel>> item, int index) {
  var sObj = item.data![index];

  return item.data!
      .map((elem) => {
            'image': "assets/images/s1.png",
            'name': elem.displayNameWOExt,
            'artists': elem.artist,
            'url': elem.uri,
            'title': elem.displayNameWOExt,
            'artist': elem.artist,
            'id': elem.id,
          })
      .toList();
}

void playerPlayProcessDebounce(List songsList, int index) {
  debounce?.cancel();
  debounce = Timer(const Duration(milliseconds: 600), () {
    PlayerInvoke.init(songsList: songsList, index: index);
  });
}

class PlayerInvoke {
  static final pageManager = getIt<PageManager>();

  static Future<void> init({
    required List songsList,
    required int index,
    bool fromMiniPlayer = false,
    bool shuffle = false,
    String? playlistBox,
  }) async {
    final int globalIndex = index < 0 ? 0 : index;
    final List finalList = songsList.toList();
    if (shuffle) finalList.shuffle();

    if (!fromMiniPlayer) {
      if (!Platform.isAndroid) {
        await pageManager.stop();
      }

      setValues(finalList, globalIndex);
    }
  }

  static Future<void> setValues(List arr, int index,
      {recommend = false}) async {
    final List<MediaItem> queue = [];
    final Map playItem = arr[index] as Map;
    final Map? nextItem =
        index == arr.length - 1 ? null : arr[index + 1] as Map?;

    queue.addAll(
      arr.map(
        (song) =>
            MediaItemConverter.mapToMediaItem(song as Map, autoplay: recommend),
      ),
    );
    updateNPlay(queue, index);
  }

  static Future<void> updateNPlay(List<MediaItem> queue, int index) async {
    try {
      await pageManager.setShuffleMode(AudioServiceShuffleMode.none);
      await pageManager.adds(queue, index);
      await pageManager.playAS();
    } catch (e) {
      print("error: $e");
    }
  }
}
