import 'package:flutter/material.dart';
import 'package:flutter_course/common/widgets/app_bar.dart';
import 'package:flutter_course/pages/video_detail/controller/video_detail_controller.dart';
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
    var arguments = ModalRoute.of(context)!.settings.arguments as Map;
    id = arguments["id"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('the id is ${id}');
    var state = ref.watch(videoDetailControllerProvider(index: int.parse(id)));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title: "Watch"),
      body: state.when(
          data: (data) => data == null ? SizedBox() : Text(data.name!),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
