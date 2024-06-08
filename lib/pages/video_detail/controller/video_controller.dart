import 'package:chewie/chewie.dart';
import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/utils/constants.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/video_detail/repo/video_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';
part 'video_controller.g.dart';

late VideoPlayerController videoPlayerController;
late ChewieController _chewieController;

@riverpod
Future<VideoItem?> videoController(VideoControllerRef ref,
    {required int index}) async {
  // VideoDetailControllerRef: access other provider
  // required int index: dependency? family provider?
  VideoReqEntity videoReqEntity = VideoReqEntity();
  videoReqEntity.Id = index;
  final rsp = await VideoRepo.GetVideoDetail(param: videoReqEntity);
  if (rsp.code == 200) {
    print('video url is ${rsp.data?.videoUrl}');
    var url = "${AppConstants.SERVER_API_URL}${rsp.data?.videoUrl}";

    videoPlayerController = VideoPlayerController.network(url);
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
    );

    // var initializeVideoPlayerFuture = videoPlayerController?.initialize();
    VideoPlayInfo videoInstance = VideoPlayInfo(
        isPlaying: false,
        initializeVideoPlayer: _chewieController,
        videoItem: rsp.data);
    // videoPlayerController?.play();

    ref
        .read(videoPlayInfoControllerProvider.notifier)
        .updateVideoPlayInfo(videoInstance);

    return rsp.data;
  } else {
    print('videoDetailController ${rsp.code}');
  }
}

@riverpod
Future<List<VideoItem>?> videoListController(VideoListControllerRef ref,
    {required int index}) async {
  // VideoDetailControllerRef: access other provider
  // required int index: dependency? family provider?
  VideoReqEntity videoReqEntity = VideoReqEntity();
  videoReqEntity.Id = index;
  final rsp = await VideoRepo.GetVideoList(param: videoReqEntity);
  if (rsp.code == 200) {
    return rsp.data;
  } else {
    print('videoDetailController ${rsp.code}');
  }
}

@riverpod
class VideoPlayInfoController extends _$VideoPlayInfoController {
  @override
  FutureOr<VideoPlayInfo> build() async {
    return VideoPlayInfo();
  }

  void updateVideoPlayInfo(VideoPlayInfo videoPlayInfo) {
    update((data) => data.copyWith(
        url: videoPlayInfo.videoItem?.videoUrl,
        initializeVideoPlayer: videoPlayInfo.initializeVideoPlayer,
        isPlaying: videoPlayInfo.isPlaying));
  }
}
