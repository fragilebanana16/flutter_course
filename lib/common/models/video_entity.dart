class VideoReqEntity {
  int? Id;

  VideoReqEntity({this.Id});
  Map<String, dynamic> toJson() => {
        "Id": Id,
      };
}

class SearchReqEntity {
  String? search;
  SearchReqEntity({this.search});
  Map<String, dynamic> toJson() => {
        "search": search,
      };
}

class VideoListRspEntity {
  int? code;
  String? msg;
  List<VideoItem>? data;
  VideoListRspEntity({this.code, this.msg, this.data});

  factory VideoListRspEntity.fromJson(Map<String, dynamic> json) =>
      VideoListRspEntity(
          code: json["code"],
          msg: json["msg"],
          data: json["data"] == null
              ? []
              : List<VideoItem>.from(
                  json["data"].map((x) => VideoItem.fromJson(x))));
}

class VideoDetailRspEntity {
  int? code;
  String? msg;
  VideoItem? data;
  VideoDetailRspEntity({this.code, this.msg, this.data});

  factory VideoDetailRspEntity.fromJson(Map<String, dynamic> json) =>
      VideoDetailRspEntity(
          code: json["code"],
          msg: json["msg"],
          data: json["data"] == null ? null : VideoItem.fromJson(json["data"]));
}

class VideoItem {
  String? userToken;
  String? name;
  String? description;
  String? thumbNail;
  String? videoUrl;
  String? videoLen;
  String? id;
  int? score;

  VideoItem(
      {this.userToken,
      this.name,
      this.description,
      this.videoUrl,
      this.videoLen,
      this.thumbNail,
      this.id,
      this.score});
  factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
        userToken: json["userToken"],
        name: json["name"],
        description: json["description"],
        thumbNail: json["thumbNail"],
        videoUrl: json["video"],
        videoLen: json["videoLen"],
        id: json["id"],
        score: json["score"],
      );
}
