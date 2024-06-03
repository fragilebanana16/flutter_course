import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/services/http_util.dart';

class VideoDetailRepo {
  static Future<VideoDetailRspEntity> GetVideoDetail(
      {VideoReqEntity? param}) async {
    var rsp = await HttpUtil()
        .post("allInOne/videoDetail", queryParameters: param?.toJson());
    print(rsp);

    return VideoDetailRspEntity.fromJson(
        rsp.data); // return with code fromjson to entity?
  }
}
