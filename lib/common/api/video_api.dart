import 'package:flutter_course/common/models/video_entity.dart';
import 'package:flutter_course/common/services/http_util.dart';

class VideoAPI {
  static Future<VideoListRspEntity> videoList() async {
    var rsp = await HttpUtil().post('/video/getVideoList');
    return VideoListRspEntity.fromJson(rsp.data);
  }
}
