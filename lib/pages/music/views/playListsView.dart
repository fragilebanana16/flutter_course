import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/playListsViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/myPlaylistCell.dart';
import 'package:flutter_course/pages/music/views/Widgets/playListSongsCell.dart';
import 'package:flutter_course/pages/music/views/Widgets/viewAllSection.dart';
import 'package:get/get.dart';

class PlaylistsView extends StatefulWidget {
  const PlaylistsView({super.key});

  @override
  State<PlaylistsView> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends State<PlaylistsView> {
  final plVM = Get.put(PlaylistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff23273B),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset("assets/images/add.png"),
          ),
        ),
        body: Container(
          color: TColor.bg,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: plVM.playlistArr.length,
                    itemBuilder: (context, index) {
                      var pObj = plVM.playlistArr[index];
                      return PlaylistSongsCell(
                        pObj: pObj,
                        onPressed: () {},
                        onPressedPlay: () {},
                      );
                    },
                  ),
                ),
                ViewAllSection(title: "My Playlists", onPressed: () {}),
                SizedBox(
                  height: 150,
                  child: Obx(
                    () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: plVM.myPlaylistArr.length,
                        itemBuilder: (context, index) {
                          var pObj = plVM.myPlaylistArr[index];

                          return MyPlaylistCell(
                            pObj: pObj,
                            onPressed: () {},
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
