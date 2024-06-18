import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/homeViewModel.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/playlistCell.dart';
import 'package:flutter_course/pages/music/views/Widgets/recommendedCell.dart';
import 'package:flutter_course/pages/music/views/Widgets/songsRow.dart';
import 'package:flutter_course/pages/music/views/Widgets/titleSection.dart';
import 'package:flutter_course/pages/music/views/Widgets/viewAllSection.dart';
import 'package:get/get.dart';

class MusicHomeView extends StatefulWidget {
  const MusicHomeView({super.key});

  @override
  State<MusicHomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<MusicHomeView> {
  final homeVM = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.bg,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.find<StartViewModel>().openDrawer();
            },
            icon: Image.asset(
              "assets/images/menu.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            )),
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xff292E4B),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: TextField(
                  controller: homeVM.txtSearch.value,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        width: 30,
                        child: Image.asset(
                          "assets/images/search.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.primaryText28,
                        ),
                      ),
                      hintText: "Search album song",
                      hintStyle: TextStyle(
                        color: TColor.primaryText28,
                        fontSize: 13,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleSection(title: "Hot Recommended"),
            SizedBox(
              height: 190,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeVM.hostRecommendedArr.length,
                  itemBuilder: (context, index) {
                    var mObj = homeVM.hostRecommendedArr[index];
                    return RecommendedCell(mObj: mObj);
                  }),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(
              title: "Playlist",
              onPressed: () {},
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeVM.playListArr.length,
                  itemBuilder: (context, index) {
                    var mObj = homeVM.playListArr[index];
                    return PlaylistCell(mObj: mObj);
                  }),
            ),
            Divider(
              color: Colors.white.withOpacity(0.07),
              indent: 20,
              endIndent: 20,
            ),
            ViewAllSection(
              title: "Recently Played",
              onPressed: () {},
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: homeVM.recentlyPlayedArr.length,
                itemBuilder: (context, index) {
                  var sObj = homeVM.recentlyPlayedArr[index];
                  return SongsRow(
                    sObj: sObj,
                    onPressed: () {},
                    onPressedPlay: () {},
                  );
                })
          ],
        ),
      ),
    );
  }
}
