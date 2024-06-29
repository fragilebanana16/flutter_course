import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/startViewModel.dart';
import 'package:flutter_course/pages/music/views/albumsView.dart';
import 'package:flutter_course/pages/music/views/allLocalSongsView.dart';
import 'package:flutter_course/pages/music/views/allSongsView.dart';
import 'package:flutter_course/pages/music/views/artistsView.dart';
import 'package:flutter_course/pages/music/views/genresView.dart';
import 'package:flutter_course/pages/music/views/playListsView.dart';
import 'package:get/get.dart';

class SongsView extends StatefulWidget {
  const SongsView({super.key});

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 6, vsync: this);
    controller?.addListener(() {
      selectTab = controller?.index ?? 0;
      setState(() {});
    });
  }

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
            ),
          ),
          title: Text(
            "Songs",
            style: TextStyle(
                color: TColor.primaryText80,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.find<StartViewModel>().openDrawer();
              },
              icon: Image.asset(
                "assets/images/search.png",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: TColor.primaryText35,
              ),
            )
          ],
        ),
        body: Container(
          color: TColor.bg,
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight - 15,
                child: TabBar(
                  controller: controller,
                  indicatorColor: TColor.focus,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                  isScrollable: true,
                  labelColor: TColor.focus,
                  labelStyle: TextStyle(
                      color: TColor.focus,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  unselectedLabelColor: TColor.primaryText80,
                  unselectedLabelStyle: TextStyle(
                      color: TColor.primaryText80,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(
                      text: "All Songs",
                    ),
                    Tab(
                      text: "Local Songs",
                    ),
                    Tab(
                      text: "Playlists",
                    ),
                    Tab(
                      text: "Albums",
                    ),
                    Tab(
                      text: "Artists",
                    ),
                    Tab(
                      text: "Genres",
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: controller,
                children: const [
                  AllSongsView(),
                  AllLocalSongsView(),
                  PlaylistsView(),
                  AlbumsView(),
                  ArtistsView(),
                  GenresView(),
                ],
              ))
            ],
          ),
        ));
  }
}
