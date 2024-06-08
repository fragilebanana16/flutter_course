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
  final String? userToken;
  final String? name;
  final String? description;
  final String? thumbNail;
  final String? videoUrl;
  final String? videoLen;
  final String? id;
  final int? score;

  const VideoItem(
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
        videoUrl: json["videoUrl"],
        videoLen: json["videoLen"],
        id: json["id"],
        score: json["score"],
      );
}

class VideoPlayInfo {
  final Future<void>? initializeVideoPlayer;
  final bool isPlaying;
  final VideoItem? videoItem;

  VideoPlayInfo(
      {this.initializeVideoPlayer,
      this.isPlaying = false,
      this.videoItem = const VideoItem()});

  VideoPlayInfo copyWith(
      {Future<void>? initializeVideoPlayer, bool? isPlaying, String? url}) {
    return VideoPlayInfo(
        initializeVideoPlayer:
            initializeVideoPlayer ?? this.initializeVideoPlayer,
        isPlaying: isPlaying ?? this.isPlaying,
        videoItem: videoItem ?? this.videoItem);
  }
}
