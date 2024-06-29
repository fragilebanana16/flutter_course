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
  const AllLocalSongsView({super.key});

  @override
  State<AllLocalSongsView> createState() => _AllSongsViewState();
}

class _AllSongsViewState extends State<AllLocalSongsView> {
  final _audioQuery = new OnAudioQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  List<Map<String, String?>> CreateListVM(
      AsyncSnapshot<List<SongModel>> item, int index) {
    var sObj = item.data![index];
    return [
      {
        'image': "assets/images/s1.png",
        'name': sObj.displayNameWOExt,
        'artists': sObj.artist,
        'url': sObj.uri,
        'title': sObj.displayNameWOExt,
        'artist': sObj.artist,
        'id': '1',
      }
    ];
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
