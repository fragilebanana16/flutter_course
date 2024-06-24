import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/audio_helpers/player_invoke.dart';
import 'package:flutter_course/pages/music/viewModel/allSongsViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/allSongRow.dart';
import 'package:flutter_course/pages/music/views/mainPlayerView.dart';
import 'package:get/get.dart';

class AllSongsView extends StatefulWidget {
  const AllSongsView({super.key});

  @override
  State<AllSongsView> createState() => _AllSongsViewState();
}

class _AllSongsViewState extends State<AllSongsView> {
  final allVM = Get.put(AllSongsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: TColor.bg,
      child: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: allVM.allList.length,
            itemBuilder: (context, index) {
              var sObj = allVM.allList[index];

              return AllSongRow(
                sObj: sObj,
                onPressed: () {},
                onPressedPlay: () {
                  // Get.to(() => const MainPlayerView());
                  playerPlayProcessDebounce(
                      allVM.allList
                          .map((sObj) => {
                                'image': sObj["image"].toString(),
                                'name': sObj["name"].toString(),
                                'artists': sObj["artists"].toString(),
                                'url': sObj["url"].toString(),
                                'title': sObj["title"].toString(),
                                'artist': sObj["artist"].toString(),
                              })
                          .toList(),
                      index);
                },
              );
            }),
      ),
    ));
  }
}
