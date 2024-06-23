import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/pages/music/viewModel/genresViewModel.dart';
import 'package:flutter_course/pages/music/views/Widgets/genreCell.dart';
import 'package:get/get.dart';

class GenresView extends StatefulWidget {
  const GenresView({super.key});

  @override
  State<GenresView> createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  final genVM = Get.put(GenresViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: TColor.bg,
      child: GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.4),
          itemCount: genVM.allList.length,
          itemBuilder: (context, index) {
            var cObj = genVM.allList[index];

            return GenreCell(
              cObj: cObj,
              onPressed: () {},
            );
          }),
    ));
  }
}
