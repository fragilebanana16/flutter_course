import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/services/http_util.dart';

class VideoRepo {
  static Future<VideoDetailRspEntity> GetVideoDetail(
      {VideoReqEntity? param}) async {
    var rsp = await HttpUtil()
        .post("/video/videoDetail", queryParameters: param?.toJson());
    print(rsp);

    return VideoDetailRspEntity.fromJson(
        rsp.data); // return with code fromjson to entity?
  }

  static Future<VideoListRspEntity> GetVideoList(
      {VideoReqEntity? param}) async {
    var rsp = await HttpUtil()
        .post("/videoSeriesList", queryParameters: param?.toJson());
    print(rsp);

    return VideoListRspEntity.fromJson(rsp.data);
  }
}
