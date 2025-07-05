import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/audio_helpers/player_invoke.dart';
import 'package:flutter_course/pages/music/viewModel/allSongsViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/allSongRow.dart';
import 'package:flutter_course/pages/music/views/mainPlayerView.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllLocalSongsView extends StatefulWidget {
  final bool shouldAutoPlay;
  const AllLocalSongsView({super.key, this.shouldAutoPlay = false});
  @override
  State<AllLocalSongsView> createState() => _AllSongsViewState();
}

class _AllSongsViewState extends State<AllLocalSongsView> {
  final _audioQuery = new OnAudioQuery();
  bool _hasAutoPlayed = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: TColor.bg,
            child: FutureBuilder(
                future: _audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true,
                    path: "/storage/emulated/0/myMusic"),
                builder: (context, item) {
                  if (item.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (item.data!.isEmpty) {
                    return Text("No Songs Found...");
                  }

                  // ✅ 自动播放逻辑（只执行一次）
                  final songs = item.data!;
                  if (widget.shouldAutoPlay && !_hasAutoPlayed) {
                    _hasAutoPlayed = true;
                    final randomIndex = (songs.length > 1)
                        ? (DateTime.now().millisecondsSinceEpoch % songs.length)
                        : 0;
                    final vm = CreateListVM(item, randomIndex);
                    Future.microtask(
                        () => playerPlayProcessDebounce(vm, randomIndex));
                  }
                  return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: item.data!.length,
                      itemBuilder: (context, index) {
                        String name = item.data![index].displayNameWOExt;
                        String? artists = item.data![index].artist;
                        String imagePath =
                            "assets/images/s2.png"; // cant find the image
                        String jsonString =
                            '{"name":"$name", "artists":"$artists", "image":"$imagePath"}';

                        Map<String, dynamic> sObj = jsonDecode(jsonString);
                        var vm = CreateListVM(item, index);
                        return AllSongRow(
                          sObj: sObj,
                          onPressed: () {},
                          onPressedPlay: () {
                            // Get.to(() => const MainPlayerView());
                            playerPlayProcessDebounce(vm, index);
                          },
                        );
                      });
                })));
  }
}
