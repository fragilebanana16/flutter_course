import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/search_bar.dart';
import 'package:flutter_course/pages/home/controller/home_controller.dart';
import 'package:flutter_course/pages/home/view/widgets/home_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late PageController _controller;

  // int controller whenever provider changes
  @override
  void didChangeDependencies() {
    _controller =
        PageController(initialPage: ref.watch(homeScreenBannerDotsProvider));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(ref),
        body: RefreshIndicator(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      const HelloText(),
                      userName(ref),
                      SizedBox(
                        height: 20.h,
                      ),
                      searchBar(),
                      SizedBox(
                        height: 14.h,
                      ),
                      HomeBanner(ref: ref, controller: _controller),
                      const HomeMenuBar(),
                      SizedBox(
                        height: 14.h,
                      ),
                      GridItem(ref: ref),
                    ],
                  ),
                )),
            onRefresh: () {
              return ref
                  .refresh(homeVideoListProvider.notifier)
                  .fetchVideoList();
            }));
  }
}
