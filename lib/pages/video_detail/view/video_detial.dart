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
import 'package:video_player/video_player.dart';

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
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('the id is ${id}');
    int? parsedInt = int.tryParse(id);
    if (parsedInt != null) {
      var state = ref.watch(videoControllerProvider(index: parsedInt));
      var videoList = ref.watch(videoListControllerProvider(index: parsedInt));
      var videoPlayInfo = ref.watch(videoPlayInfoControllerProvider);
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
                            // video here
                            videoPlayInfo.when(
                                data: (data) => Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${AppConstants.SERVER_API_URL}${data.videoItem?.thumbNail}"))),
                                      width: 325.w,
                                      height: 200.h,
                                      child: FutureBuilder(
                                        future: data.initializeVideoPlayer,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return videoPlayerController == null
                                                ? Container()
                                                : Stack(
                                                    children: [
                                                      VideoPlayer(
                                                          videoPlayerController!),
                                                    ],
                                                  );
                                          } else {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                error: (error, stackTrace) =>
                                    Text(error.toString()),
                                loading: () => SizedBox(
                                        child: const Center(
                                      child: CircularProgressIndicator(),
                                    ))),
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
                  loading: () => SizedBox(
                        height: 500.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
              // series
              videoList.when(
                  data: (data) => data == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            VideoSeries(
                              videoList: data
                                  .where((element) => element.id != id)
                                  .toList(),
                            )
                          ],
                        ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => SizedBox(
                        height: 500.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
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
