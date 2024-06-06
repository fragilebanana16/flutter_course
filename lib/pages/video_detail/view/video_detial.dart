import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_course/common/utils/app_colors.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/common/widgets/app_shadow.dart';
import 'package:flutter_course/common/widgets/image_widget.dart';
import 'package:flutter_course/common/widgets/text_widgets.dart';
import 'package:flutter_course/pages/video_detail/controller/video_controller.dart';
import 'package:flutter_course/pages/video_detail/view/Widgets/video_detail_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDetail extends ConsumerStatefulWidget {
  const VideoDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoDetailState();
}

class _VideoDetailState extends ConsumerState<VideoDetail> {
  late var id;

  @override
  void didChangeDependencies() {
    var arguments;
    try {
      arguments = ModalRoute.of(context)!.settings.arguments as Map;
      id = arguments["id"];
    } catch (_) {
      id = '123';
      print('video_detial_catch exception');
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('the id is ${id}');
    int? parsedInt = int.tryParse(id);
    if (parsedInt != null) {
      var state = ref.watch(videoControllerProvider(index: parsedInt));
      var videoList = ref.watch(videoListControllerProvider(index: parsedInt));
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(title: "Watch"),
        body: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            VideoDetailThumbnail(
                              videoItem: data,
                            ),
                            VideoDetailBrief(
                              videoItem: data,
                            ),
                            VideoMoreDetail(
                              videoItem: data,
                            ),
                          ],
                        ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
              // series
              videoList.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            VideoSeries(
                              videoList: data,
                            )
                          ],
                        ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ))
            ],
          )),
        ),
      );
    } else {
      print('Failed to parse the string as an integer!');
      return Container();
    }
  }
}
