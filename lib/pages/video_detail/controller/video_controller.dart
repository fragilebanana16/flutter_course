import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/global.dart';
import 'package:flutter_course/pages/video_detail/repo/video_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'video_controller.g.dart';

@riverpod
Future<VideoItem?> videoController(VideoControllerRef ref,
    {required int index}) async {
  // VideoDetailControllerRef: access other provider
  // required int index: dependency? family provider?
  VideoReqEntity videoReqEntity = VideoReqEntity();
  videoReqEntity.Id = index;
  final rsp = await VideoRepo.GetVideoDetail(param: videoReqEntity);
  if (rsp.code == 200) {
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
