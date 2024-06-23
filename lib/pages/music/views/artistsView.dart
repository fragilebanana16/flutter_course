import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/artistsViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/artistRow.dart';
import 'package:flutter_course/pages/music/views/artistDetailsView.dart';
import 'package:get/get.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({super.key});

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  final artVM = Get.put(ArtistsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: TColor.bg,
      child: Obx(
        () => ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            itemCount: artVM.allList.length,
            itemBuilder: (context, index) {
              var aObj = artVM.allList[index];

              return ArtistRow(
                aObj: aObj,
                onPressed: () {
                  Get.to(() => const ArtistDetailsView());
                },
                onPressedMenuSelect: (selectIndex) {},
              );
            }),
      ),
    ));
  }
}
