import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/search_bar.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/home/view/widgets/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildAppBar(title: "Home"),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                helloText(),
                userName(),
                SizedBox(
                  height: 20.h,
                ),
                searchBar(),
                SizedBox(
                  height: 20.h,
                ),
                banner(ref: ref)
              ],
            ),
          )),
    );
  }
}
