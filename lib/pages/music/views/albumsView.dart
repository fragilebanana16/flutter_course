import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/albumsViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/albumCell.dart';
import 'package:flutter_course/pages/music/views/albumDetailsView.dart';
import 'package:get/get.dart';

class AlbumsView extends StatefulWidget {
  const AlbumsView({super.key});

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final albumVM = Get.put(AlbumViewModel());

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);

    var cellWidth = (media.width - 40.0 - 20.0) * 0.5;

    return Scaffold(
        body: Container(
      color: TColor.bg,
      child: Obx(
        () => GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: cellWidth / (cellWidth + 45.0),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10),
            itemCount: albumVM.allList.length,
            itemBuilder: (context, index) {
              var aObj = albumVM.allList[index];
              return AlbumCell(
                aObj: aObj,
                onPressed: () {
                  Get.to(() => const AlbumDetailsView());
                },
                onPressedMenu: (selectIndex) {
                  if (kDebugMode) {
                    print(index);
                  }
                },
              );
            }),
      ),
    ));
  }
}
